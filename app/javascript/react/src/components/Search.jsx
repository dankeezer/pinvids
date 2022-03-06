import * as React from 'react'
import * as ReactDOM from 'react-dom'

function search() {
  var buildMachineLine = (m) => `<a href="/machines/${m.id}"><div class="mb-1 mx-1">${m.name}</div></a>`;
  var buildTournamentLine = (t) => `<a href="/tournaments/${t.id}"><div class="mb-1 mx-1">${t.name}</div></a>`;
  var autoCompleteResults = document.getElementById('autocomplete-results');
  var showDropdown = () => autoCompleteResults.style.display = "block";
  var hideDropdown = () => autoCompleteResults.style.display = "none";
  var onKeyUp = (value) => {
    if (value.length == 0) {
      autoCompleteResults.innerHTML = "";
      return;
    };
    showDropdown();
    fetch(`/search?query=${value}`, {
      headers: {
        "Content-Type":  "application/json"
      };
    }).then(response => response.json())
      .then(json => {
        resultArray = [].concat(json.machines.map(buildMachineLine), json.tournaments.map(buildTournamentLine))
        autoCompleteResults.innerHTML = resultArray.join('');
      });
  };
  // For the "[x]" on the right of the search bar:
  var onSearch = (input) => {
    input.value === "" ? hideDropdown() : showDropdown()
  };
};

export default search
