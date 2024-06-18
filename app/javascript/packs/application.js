// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

/*global $*/

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import './calendar';
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()


//投稿時、1枚ずつ画像の追加と削除を出来るようにする
$(document).on('turbolinks:load', function() {
  $('#add-image-field').on('click', function() {
    var imageField = `
      <div class="field">
        <input type="file" name="post[images][]" multiple="true" direct_upload="true">
        <button type="button" class="remove-image-field">削除</button>
      </div>`;
    $('#image-fields').append(imageField);
  });

  $('#image-fields').on('click', '.remove-image-field', function() {
    $(this).closest('.field').remove();
  });

  $('#image-fields').on('change', 'input[type="file"]', function() {
    var files = this.files;
    var preview = $(this).siblings('.image-preview');
    if (preview.length == 0) {
      preview = $('<div class="image-preview"></div>');
      $(this).after(preview);
    }
    preview.empty();
    for (var i = 0; i < files.length; i++) {
      var reader = new FileReader();
      reader.onload = function(e) {
        var img = $('<img>').attr('src', e.target.result).css('width', '100px');
        preview.append(img);
      };
      reader.readAsDataURL(files[i]);
    }
  });
});
