// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus";
import axios from "axios";

export default class extends Controller {
  static targets = ["followButton"];

  follow(event) {
    event.preventDefault();
    const user = this.followButtonTarget.dataset.user;
    const button = this.followButtonTarget;

    axios
      .post(`/api/users/${user}/follow`)
      .then(function (response) {
        let status = response.data.stauts;
        switch (status) {
          case "sign_in_first":
            alert("你必須先登入");
            break;
          default:
            button.innerHTML = status;
        }
        console.log(response.data);
      })
      .catch(function (error) {
        console.log(error);
      });
    console.log(user);
  }
}
