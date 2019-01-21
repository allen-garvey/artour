// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../../css/admin.scss"

import { initializeAutofillImageName } from './autofill_image_name.js';
initializeAutofillImageName();

import { initializeAddTags } from './add_tags.js';
initializeAddTags();

import { initializeAddImagesToPost } from './add_images_to_post.js';
initializeAddImagesToPost();

import { initializeFormDeleteButton } from './form_delete_button.js';
initializeFormDeleteButton();

import { initializeSetCoverImage } from './set_cover_image.js';
initializeSetCoverImage();

import { initializeAutofillSlug } from './slugify.js';
initializeAutofillSlug();