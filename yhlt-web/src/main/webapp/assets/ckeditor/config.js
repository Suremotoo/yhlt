/*
Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	config.uiColor = '#e5e5e5';
	config.skin = 'kama';
	config.filebrowserUploadUrl = dynamicURL+'/system/file/uploadImg';
	config.filebrowserFlashUploadUrl = dynamicURL+'/system/file/uploadFlash';
	config.toolbar_Full =
		[
		    { name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
		    { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
//		    { name: 'editing',     items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
//		    { name: 'forms',       items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
//		    '/',
		    { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
//		    { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
//		    { name: 'links',       items : [ 'Link','Unlink','Anchor' ] },
//		    { name: 'insert',      items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
		    { name: 'insert',      items : [ 'Image','Flash'] },
		    '/',
		    { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
		    { name: 'colors',      items : [ 'TextColor','BGColor' ] },
		    { name: 'tools',       items : [ 'Maximize', 'ShowBlocks','-','About' ] }
		];
	
};
