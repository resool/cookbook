function getSelectedIngredients() {
  const selectedVegetables = [];
  $('input[name="ingredient[]"]:checked').each(function() {
      selectedVegetables.push($(this).val());
  });
  
  return selectedVegetables;
}

function getIngredients() {
  const ingredients = $('.list-group');

  $.ajax({
    url: 'api/v1/ingredients',
    method: 'GET',
    success: function(data) {
      ingredients.empty();
      data.forEach(function(ingredient) {
        ingredient = `
              <div class="list-group-item">  
                <div class="me-2">
                  <input type="checkbox" class="form-check-input me-2" name="ingredient[]" value="${ingredient.id}">
                  ${ingredient.name}
                </div>
              </div>

          `;
          ingredients.append(ingredient);
      });
  },
  error: function(error) {
      console.error('error:', error);
  }
});
};

function saveIngredient() {
  const ingredient = $('input[name="input"]').val();

  $.ajax({
    url: 'api/v1/ingredients',
    method: 'POST',
    contentType: 'application/json',
    data: JSON.stringify({ input: ingredient }),
    success: function(response) { getIngredients() },
    error: function(error) {
      $('#main-alert').text(error.responseJSON.error).addClass('alert-danger')
      setTimeout(function() { $('#main-alert').removeClass('alert-danger').text(' ') }, 3000);
    }
});
};

function handleRecipeSuccess(recipe) {
  handleRecipeCompletion();
  $('#recipe').removeClass('alert-warning');
  $('#recipe').addClass('alert-success');
  $('#recipe').html(recipe.content);
}

function handleRecipeFailure(recipe) {
  handleRecipeCompletion();
  $('#recipe').html(recipe.content);
  $('#recipe').addClass('alert-danger')
  setTimeout(function() { $('#recipe-failure').hide() }, 1000);
}

function handleRecipeCompletion() {
  $('#recipe').removeClass('alert-warning');
  $("#new-recipe button").prop("disabled", false);
}

function refreshRecipe(recipe) {
  console.log('refreshRecipe')
  console.log(recipe.status)
  if (recipe.status == 'valid') { handleRecipeSuccess(recipe) }
  else if (recipe.status == 'failure') { handleRecipeFailure(recipe) }
  else {
    $('#recipe').text(recipe.status);
    $('#recipe').addClass('alert-warning')
    setTimeout(function() { getRecipe(recipe.id) }, 3000); 
  }
}

function getRecipe(recipeId) {
  console.log('getRecipe')
  $.ajax({
    url: "api/v1/recipes/" + recipeId,
    method: 'GET',
    success: function(data) { refreshRecipe(data); },
    error: function(error) { console.error('error:', error);}
  })
}

function letHimCook() {
  const ingredients = $('input[name="input"]').val();
  $('#recipe').removeClass('alert-warning alert-success alert-danger')
  $("#new-recipe button").prop("disabled", true);

  $.ajax({
    url: 'api/v1/recipes',
    method: 'POST',
    contentType: 'application/json',
    data: JSON.stringify({ ingredient_ids: getSelectedIngredients() }),
    success: function(response) { refreshRecipe(response) },
    error: function(error) { alert('dddd'); }
});
};

$(document).ready(function() {
  getIngredients();
  $('#new-ingredient form').on('submit', function(event){
    event.preventDefault();
    saveIngredient();
  });

  $('#new-recipe form').on('submit', function(event){
    event.preventDefault();
    letHimCook();
  });
});