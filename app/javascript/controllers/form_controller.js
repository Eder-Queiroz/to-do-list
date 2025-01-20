import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  delete(event) {
    event.preventDefault(); // Impede o envio do formulário

    const confirmed = confirm("Tem certeza que deseja excluir este item?");
    if (confirmed) {
      const button = event.target;
      const url = button.getAttribute("formaction"); // Obtém a URL de exclusão

      fetch(url, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
      })
        .then((response) => {
          if (response.ok) {
            window.location.href = button.dataset.redirectUrl; // Redireciona após a exclusão
          } else {
            console.error("Erro ao excluir o item");
          }
        })
        .catch((error) => console.error(error));
    }
  }
}
