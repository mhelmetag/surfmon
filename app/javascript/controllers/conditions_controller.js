import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="conditions"
export default class extends Controller {
  changeSource(event) {
    const index = event.target.id.split("_")[3]; // alert_conditions_attributes_1_source
    const source = event.target.selectedOptions[0].value;

    get(`/conditions/fields?index=${index}&source=${source}`, {
      responseKind: "turbo-stream",
    });
  }

  changeField(event) {
    const index = event.target.id.split("_")[3]; // alert_conditions_attributes_1_field
    const source = document.getElementById(
      `alert_conditions_attributes_${index}_source`
    ).selectedOptions[0].value;
    const field = event.target.selectedOptions[0].value;

    get(`/conditions/value?index=${index}&source=${source}&field=${field}`, {
      responseKind: "turbo-stream",
    });
  }

  add(event) {
    event.preventDefault();

    const alertId = event.target.form.action.split("/")[4]; // http://localhost:3000/alerts/1

    get(`/conditions/add?alert_id=${alertId}`, {
      responseKind: "turbo-stream",
    });
  }
}
