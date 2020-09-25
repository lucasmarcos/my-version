import ReactDOM from "react-dom";

const root = document.getElementById("root");
const changeRoot = (component) => ReactDOM.render(component(), root);

const SideBar = () => {
  return (
    <div className="sidebar">
    </div>
  )
}

const Administrador = () => {
  return (
    <>
      <SideBar/>
      <div className="main"></div>
    </>
  )
}

const Tecnico = () => {
  return (
    <div className="main"></div>
  )
}

const Proprietario = () => {
  return (
    <div className="main"></div>
  )
}

const App = () => {
  return (
    <div>
      <ul>
        <li onClick={() => changeRoot(Administrador)}>
          Administrador
        </li>

        <li onClick={() => changeRoot(Tecnico)}>
          Tecnico
        </li>

        <li onClick={() => changeRoot(Proprietario)}>
          Proprietario
        </li>
      </ul>
    </div>
  );
};

changeRoot(App);
