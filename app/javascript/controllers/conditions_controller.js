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
    const $source = document.getElementById(
      `alert_conditions_attributes_${index}_source`
    ).selectedOptions[0].value;
    const field = event.target.selectedOptions[0].value;

    get(`/conditions/value?index=${index}&source=${$source}&field=${field}`, {
      responseKind: "turbo-stream",
    });
  }

  add(event) {
    event.preventDefault();

    const index = document.getElementsByClassName("condition").length; // already +1 for zero based index
    const formUrl = new URL(event.target.form.action);
    let addUrl;
    if (formUrl.pathname === "/alerts") {
      addUrl = `/conditions/add?index=${index}`;
    } else {
      const alertId = formUrl.pathname.split("/")[2]; // /alerts/1
      addUrl = `/conditions/add?index=${index}&alert_id=${alertId}`;
    }

    get(addUrl, {
      responseKind: "turbo-stream",
    });
  }

  delete(event) {
    event.preventDefault();

    const index = event.currentTarget.id.split("_")[2]; // alert_conditions_1_destroy_button
    const $destroyField = document.getElementById(
      `alert_conditions_attributes_${index}__destroy`
    );

    if ($destroyField) {
      // if persisted
      // replace with strikethrough condition string
      const formUrl = new URL(event.currentTarget.form.action);
      const alertId = formUrl.pathname.split("/")[2]; // /alerts/1
      const deleteUrl = `/conditions/delete?index=${index}&alert_id=${alertId}`;

      get(deleteUrl, {
        responseKind: "turbo-stream",
      });
    } else {
      const $condition = event.currentTarget.parentElement.parentElement;
      const $conditionLabel = $condition.previousElementSibling;

      $condition.remove();
      $conditionLabel.remove();
    }
  }
}
