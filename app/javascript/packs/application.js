// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

/*global $*/

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import $ from "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

import './calendar';
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.css';
import { Japanese } from 'flatpickr/dist/l10n/ja.js';

import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';
import 'slick-carousel/slick/slick.min.js';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// 特徴表示
$(document).ready(function() {
  $('.feature-genre-name').on('click', function() {
    // アイコンの切り替え
    $(this).find('.toggle-icon').toggleClass('fa-chevron-right fa-chevron-down');
    // .features をトグル（表示・非表示）する
    $(this).closest('.feature-genre').next('.features').slideToggle();
  });
});

// 投稿画像の変更の際のフォームの表示
$(document).ready(function() {
  $('.image-change').on('click', function() {
    // アイコンの切り替え
    $(this).find('.toggle-icon').toggleClass('fa-chevron-right fa-chevron-down');
    // .features をトグル（表示・非表示）する
    $(this).closest('.images').next('.image-form').slideToggle();
  });
});

//投稿時、1枚ずつ画像の追加と削除を出来るようにする
$(document).on('turbolinks:load', function() {
  $('#add-image-field').on('click', function() {
    var imageField = `
      <div class="field">
        <input type="file" name="post[images][]" multiple="true" direct_upload="true">

      </div>`;
    $('#image-fields').append(imageField);
  });

  $('#image-fields').on('click', '.remove-image-field', function() {
    $(this).closest('.field').remove();
  });

  $('#image-fields').on('change', 'input[type="file"]', function() {
    var files = this.files;
    var preview = $(this).siblings('.image-preview');
    var removeBtn = '<button type="button" class="remove-image-field">削除</button>'
    if (preview.length == 0) {
      preview = $(`<div class="image-preview"></div>`);
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
    preview.siblings('button').remove();
    preview.after(removeBtn);
  });
});

// 投稿されている画像をスライドショー形式で表示する
document.addEventListener('turbolinks:load', () => {
  $('.slider').slick({
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 6000,
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
