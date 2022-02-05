import { Controller } from "@hotwired/stimulus";
import debounce from "lodash.debounce";
import { get } from "@rails/request.js";

// Connects to data-controller="subregions"
export default class extends Controller {
  initialize() {
    this.search = debounce(this.search.bind(this), 500);
  }

  search(event) {
    const query = event.target.value;

    get(`/subregions/search?query=${query}`, {
      responseKind: "turbo-stream",
    });
  }

  select(event) {
    const $selection = event.target.selectedOptions[0];
    const $subregionName = document.getElementById("alert_subregion_name");
    const $subregionId = document.getElementById("alert_subregion_id");

    $subregionName.value = $selection.text;
    $subregionId.value = $selection.value;
  }
}
