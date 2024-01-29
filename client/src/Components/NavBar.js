const NavBar = () => {
  const navigateTo = (target) => {
    window.location.href = target;
  };

  return (
    <>
      <nav className="navbar navbar-expand-lg bg-dark navbar-dark fixed-top">
        <div className="container">
          <div className="navbar-brand">VideoWorld</div>
          <button
            aria-label="hamburger menu"
            className="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#nav-menu"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="nav-menu">
            <ul className="navbar-nav ms-auto">
              <li className="nav-item">
                <button
                  type="button"
                  className="nav-link"
                  onClick={() => navigateTo("#home")}
                >
                  Home
                </button>
              </li>
              <li className="nav-item">
                <button
                  type="button"
                  className="nav-link"
                  onClick={() => navigateTo("#recommendations")}
                >
                  Recommendations
                </button>
              </li>
              <li className="nav-item">
                <button
                  type="button"
                  className="nav-link"
                  onClick={() => navigateTo("#contact")}
                >
                  Contact
                </button>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </>
  );
};

export default NavBar;
