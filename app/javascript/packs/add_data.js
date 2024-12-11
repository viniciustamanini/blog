console.log('running');

document.addEventListener('turbo:load', () => {
  document.querySelector('div#skills').addEventListener('click', (e) => {
    if (e.target.id === 'add-skill-btn') {
      e.preventDefault();
      let template = document.querySelector('#skill-fields-template').innerHTML;
      let newSkillFields = document.createElement('div');
      newSkillFields.classList.add('skill-fields');
      newSkillFields.innerHTML = template;
      document.querySelector('div#skills').appendChild(newSkillFields);
    }
  });
});
