-- Use document-level processing to access metadata properly
return {
  {
    Meta = function(meta)
      -- Store metadata globally
      _G.doc_meta = meta
      return meta
    end
  },
  {
    Code = function(el)
      if el.classes:includes("email-link") then

        -- Parse attributes from the code span
        local recipient = el.attributes["recipient"] or "[tutee@students.plymouth]"
        local subject = el.attributes["subject"] or
                       (_G.doc_meta.email_title and pandoc.utils.stringify(_G.doc_meta.email_title)) or
                       "Tutorial Suggestion"
        -- Handle email body - preserve line breaks from YAML
        local body = el.attributes["body"]
        if not body and _G.doc_meta.email_body then
          -- For YAML literal blocks (|), the content comes as a string with embedded newlines
          -- Let's try to extract the raw text and preserve formatting
          body = tostring(_G.doc_meta.email_body)

          -- If it's still a table, try to extract blocks with line breaks
          if type(_G.doc_meta.email_body) == "table" then
            local body_parts = {}
            for _, block in ipairs(_G.doc_meta.email_body) do
              if block.t == "Para" then
                -- Add paragraph content and double line break for paragraph separation
                table.insert(body_parts, pandoc.utils.stringify(block))
                table.insert(body_parts, "\n\n")
              elseif block.t == "Plain" then
                -- Plain text blocks
                table.insert(body_parts, pandoc.utils.stringify(block))
                table.insert(body_parts, "\n")
              end
            end
            -- Remove trailing newlines and join
            local result = table.concat(body_parts, ""):gsub("\n\n$", ""):gsub("\n$", "")
            if #result > 0 then
              body = result
            end
          end
        end
        body = body or ""

        local text = el.text:match("%S") and el.text or "Click here to send an email"

        -- Proper URL encoding for email content
        local function url_encode(str)
          -- Handle line breaks first - convert to proper email line breaks
          str = str:gsub("\r\n", "\n")  -- Normalize line endings
                   :gsub("\r", "\n")    -- Convert Mac line endings

          -- Convert to percent encoding
          return str:gsub("([^A-Za-z0-9%-_%.~])", function(c)
            return string.format("%%%02X", string.byte(c))
          end)
        end

        -- Create mailto URL with proper URL encoding
        local mailto_url = string.format("mailto:%s?subject=%s&body=%s",
          recipient,
          url_encode(subject),
          url_encode(body)
        )

        return pandoc.RawInline("html",
          string.format(
            '<a href="%s" class="btn btn-primary">%s</a>',
            mailto_url,
            text
          )
        )
      end
    end
  }
}
