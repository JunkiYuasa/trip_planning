// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

/*global $*/

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

import './calendar';
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.css';
import { Japanese } from 'flatpickr/dist/l10n/ja.js';


Rails.start()
Turbolinks.start()
ActiveStorage.start()


//投稿時、1枚ずつ画像の追加と削除を出来るようにする
$(document).on('turbolinks:load', function() {
  $('#add-image-field').on('click', function() {
    $('.image-upload-field').trigger('click');
  });

  $(document).on('change', '.image-upload-field', function() {
    var files = this.files;

    for (var i = 0; i < files.length; i++) {
      var reader = new FileReader();
      reader.onload = function(e) {
        var imageField = `
          <div class="field">
            <img src="${e.target.result}" style="width: 100px;">
            <button type="button" class="remove-image-field">削除</button>
          </div>`;
        $('#image-preview-container').append(imageField);
      };
      reader.readAsDataURL(files[i]);
    }
  });

  $(document).on('click', '.remove-image-field', function() {
    $(this).closest('.field').remove();
    // Optionally, you can clear the associated file input if needed:
    // $('.image-upload-field').val(null);
  });
});


// プランの日時選択
document.addEventListener('DOMContentLoaded', () => {
  flatpickr('.datepicker', {
    locale: Japanese,
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    time_24hr: true
  });
});