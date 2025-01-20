import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list"];

  connect() {
    console.log("Items controller connected");
  }

  dragstart(event) {
    event.dataTransfer.setData("text/plain", event.target.dataset.id);
  }

  dragover(event) {
    event.preventDefault();
  }

  drop(event) {
    event.preventDefault();
    const itemId = event.dataTransfer.getData("text/plain");
    const status = event.currentTarget.dataset.status;

    this.updateStatus(itemId, status);
  }

  updateStatus(itemId, status) {
    const listId = this.element.dataset.listId;
    const url = `/lists/${listId}/items/${itemId}/update_status`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
      },
      body: JSON.stringify({ status }),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to update item status");
        }
        return response.json();
      })
      .then((data) => {
        if (data.success) {
          // Atualizar o DOM
          this.moveItemToNewStatus(itemId, status);
        } else {
          console.error(data.error);
        }
      })
      .catch((error) => console.error("Error updating status:", error));
  }

  moveItemToNewStatus(itemId, status) {
    // Seleciona o item pelo ID
    const item = this.element.querySelector(`[data-id="${itemId}"]`);

    if (!item) return;

    // Remove o item da coluna atual
    item.parentElement.removeChild(item);

    // Encontra a nova coluna com base no status
    const targetColumn = this.element.querySelector(
      `[data-status="${status}"] .grid`
    );

    if (targetColumn) {
      // Adiciona o item à nova coluna
      targetColumn.appendChild(item);
    }
  }
}
