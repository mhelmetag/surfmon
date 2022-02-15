import { Controller } from "@hotwired/stimulus";
import debounce from "lodash.debounce";
import { get } from "@rails/request.js";

// Connects to data-controller="subregions"
export default class extends Controller {
  initialize() {
    this.search = debounce(this.search.bind(this), 500);
  }

  open(event) {
    event.preventDefault();

    get(`/subregion/open`, {
      responseKind: "turbo-stream",
    });

    toggleModalMode();
  }

  search(event) {
    const query = event.target.value;

    get(`/subregion/search?query=${query}`, {
      responseKind: "turbo-stream",
    });
  }

  close(event) {
    event.preventDefault();

    removeSubregionSearch();
  }

  update(event) {
    event.preventDefault();

    const $subregionSelect = document.getElementById("subregion_select");
    const $selection = $subregionSelect.selectedOptions[0];
    const $subregionName = document.getElementById("alert_subregion_name");
    const $subregionId = document.getElementById("alert_subregion_id");

    $subregionName.value = $selection.text;
    $subregionId.value = $selection.value;

    removeSubregionSearch();
  }
}

const removeSubregionSearch = () => {
  const $subregionSearch = document.getElementById("subregion_search");

  $subregionSearch.remove();

  toggleModalMode();
};

const toggleModalMode = () => {
  const $html = document.getElementsByTagName("html")[0];

  $html.classList.toggle("is-clipped");
};
