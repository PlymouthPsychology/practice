document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("a.email-link").forEach(link => {
    link.addEventListener("click", (e) => {
      e.preventDefault();

      const recipient = link.dataset.recipient;
      const subject   = encodeURIComponent(link.dataset.subject);
      const body      = encodeURIComponent(link.dataset.body);

      window.location.href = `mailto:${recipient}?subject=${subject}&body=${body}`;
    });
  });
});
