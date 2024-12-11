document.addEventListener("DOMContentLoaded", () => {
  const checkbox = document.getElementById("auto_fill_date_checkbox");
  const datetimeFields = {
    year: document.getElementById("post_published_at_1i"),
    month: document.getElementById("post_published_at_2i"),
    day: document.getElementById("post_published_at_3i"),
    hour: document.getElementById("post_published_at_4i"),
    minute: document.getElementById("post_published_at_5i")
  };

  const fillDatetimeFields = (date) => {
    datetimeFields.year.value = date.getFullYear();
    datetimeFields.month.value = date.getMonth() + 1;
    datetimeFields.day.value = date.getDate();
    datetimeFields.hour.value = date.getHours();
    datetimeFields.minute.value = date.getMinutes().toString().padStart(2, '0');
  };

  const clearDatetimeFields = () => {
    Object.values(datetimeFields).forEach(field => field.value = "");
  };

  checkbox.addEventListener("change", () => {
    if (checkbox.checked) {
      const now = new Date();
      fillDatetimeFields(now);
    } else {
      clearDatetimeFields();
    }
  });
});

