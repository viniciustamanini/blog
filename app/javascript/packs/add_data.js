const handleNestedFormClick = (e) => {
  const addBtn = e.target.closest("[data-add-nested]");
  if (addBtn) {
    e.preventDefault();
    const listId = addBtn.dataset.addNested;
    const templateId = addBtn.dataset.templateId;
    const list = document.getElementById(listId);
    const template = document.getElementById(templateId);

    if (list && template) {
      const uniqueId = `${Date.now()}${Math.floor(Math.random() * 1000)}`;
      const html = template.innerHTML.replace(/NEW_RECORD/g, uniqueId);
      list.insertAdjacentHTML("beforeend", html);
    }
    return;
  }

  const removeBtn = e.target.closest("[data-remove-nested]");
  if (removeBtn) {
    e.preventDefault();
    const item = removeBtn.closest("[data-nested-item]");
    if (!item) return;

    const destroyInput = item.querySelector("input[name*='[_destroy]']");
    const idInput = item.querySelector("input[name*='[id]']");

    if (idInput && idInput.value) {
      if (destroyInput) {
        destroyInput.value = "1";
        destroyInput.checked = true;
      }
      item.style.display = "none";
    } else {
      item.remove();
    }
  }
};

document.addEventListener("click", handleNestedFormClick);
