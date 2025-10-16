# Claude Code Preferences

## Project Context
- RStudio Quarto document project
- Builds website using Quarto
- Hosted on GitHub Pages
- Target audience: UK undergraduate psychology students

## Writing Style
- Simple, straightforward language
- Written for undergraduate level
- UK-focused content and terminology
- Clear and accessible explanations

## Code Standards
- Keep R/Rmd/qmd code simple and easy to follow
- No comments unless absolutely necessary
- Focus on readability and learning
- Use basic, educational examples

## File Management
- Prefer editing existing files over creating new ones
- Only create files when absolutely necessary
- No proactive documentation creation unless requested

## QR Codes and URLs for Tutorial Materials
- Student handout pages are created as separate .qmd files in the tutorials/ directory
- URLs in links use .html extension (e.g., `[Material](stage1_example.html)`)
- QR code images are stored in images/ directory
- QR code image references use .png extension (e.g., `![QR code](../images/qr_example.png){width=50%}`)
- QR codes point to the full GitHub Pages URL: `https://plymouthpsychology.github.io/practice/tutorials/[filename].html`
- Generate QR codes using online tools (e.g., qr-code-generator.com) pointing to the full URL
- Name QR code images descriptively: `qr_[page_name].png` (e.g., `qr_critique_examples.png`)