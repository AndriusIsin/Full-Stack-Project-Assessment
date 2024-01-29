const Footer = () => {
  return (
    <footer
      id="contact"
      className="bg-dark text-light text-center p-4 position-relative"
    >
      <div className="container">
        <p className="lead">Copyright &copy; 2023 Andrius Isin</p>

        <button
          onClick={() => {
            window.scrollTo({ top: 0, behavior: "smooth" });
          }}
          aria-label="Go to top"
          className="position-absolute top-0 end-0 p-3 bg-transparent border-0"
        >
          <i className="bi bi-arrow-up-circle h1 text-primary"></i>
        </button>
      </div>
    </footer>
  );
};
export default Footer;
