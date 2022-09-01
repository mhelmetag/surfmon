import { Controller } from "@hotwired/stimulus";
import debounce from "lodash.debounce";
import { get } from "@rails/request.js";

// Connects to data-controller="providers"
export default class extends Controller {
  initialize() {
    this.search = debounce(this.search.bind(this), 500);
  }

  open(event) {
    event.preventDefault();

    const providerType = document.getElementById("alert_provider_type").value;

    get(`/provider_search/open?provider_type=${providerType}`, {
      responseKind: "turbo-stream",
    });

    toggleModalMode();
  }

  search(event) {
    const providerType = document.getElementById("alert_provider_type").value;
    const query = event.target.value;

    get(
      `/provider_search/search?provider_type=${providerType}&query=${query}`,
      {
        responseKind: "turbo-stream",
      }
    );
  }

  close(event) {
    event.preventDefault();

    removeProviderSearch();
  }

  update(event) {
    event.preventDefault();

    const $providerSearchSelect = document.getElementById(
      "provider_search_select"
    );
    const $selection = $providerSearchSelect.selectedOptions[0];
    const $providerSearchName = document.getElementById(
      "alert_provider_search_name"
    );
    const $providerSearchId = document.getElementById(
      "alert_provider_search_id"
    );

    $providerSearchName.value = $selection.text;
    $providerSearchId.value = $selection.value;

    removeProviderSearch();
  }
}

const removeProviderSearch = () => {
  const $providerSearch = document.getElementById("provider_search");

  $providerSearch.remove();

  toggleModalMode();
};

const toggleModalMode = () => {
  const $html = document.getElementsByTagName("html")[0];

  $html.classList.toggle("is-clipped");
};
