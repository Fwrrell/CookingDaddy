class Navbar extends HTMLElement {
  connectedCallback() {
    this.innerHTML = `
      <nav class="justify-between">
        <div class="left-side items-center gap-6">
          <!-- Logo -->
          <div class="profile items-center"></div>
          <div class="list-menu flex text-base">
            <a class="pill" href="">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-house preview-icon"
              >
                <path d="M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8" />
                <path
                  d="M3 10a2 2 0 0 1 .709-1.528l7-6a2 2 0 0 1 2.582 0l7 6A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"
                /></svg
              >Home
            </a>
            <a class="pill" href="Explore.html">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-compass preview-icon"
              >
                <circle cx="12" cy="12" r="10" />
                <path
                  d="m16.24 7.76-1.804 5.411a2 2 0 0 1-1.265 1.265L7.76 16.24l1.804-5.411a2 2 0 0 1 1.265-1.265z"
                /></svg
              >Explore</a
            >
            <a class="pill" href="login.html">Login</a>
            <a class="pill" href="">Register</a>
          </div>
        </div>
        <div class="right-side">
          <!-- Profile -->
          <div class="profile"></div>
          <div class="profile-data">
          </div>
        </div>
      </nav>
      `;

    const active = (this.getAttribute("active") || "").trim().toLowerCase();
    this.querySelectorAll("a").forEach((link) => {
      if (link.textContent.trim().toLowerCase() === active) {
        link.classList.add("active");
      }
    });
  }
}
customElements.define("app-navbar", Navbar);
