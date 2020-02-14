//= require new_ckeditor/custom/ckeditor.js


ClassicEditor
			.create( document.querySelector( '#editor' ), {
				toolbar: {
					items: [
						'heading',
						'|',
						'bold',
						'italic',
						'link',
						'bulletedList',
						'numberedList',
						'|',
						'indent',
						'outdent',
						'|',
						'imageUpload',
						'blockQuote',
						'insertTable',
            'mediaEmbed',
						'undo',
            'redo',
            '|',
            'autoformat',
            'image',
            'imageStyle',
            'imageToolbar',
            'pastFromOffice',
            'table',
            'tableToolbar',
            'fontSize',
            'fontColor',
            'fontBackgroundColor',
            'horizontalLine',
            'essentials',
            'paragraph'
					]
        },
        simpleUpload: {
          // The URL that the images are uploaded to.
          uploadUrl: '/upload',
          // Headers sent along with the XMLHttpRequest to the upload server.
          headers: {
              'X-CSRF-TOKEN': 'CSFR-Token'
          }
        },
				language: 'en',
				image: {
					toolbar: [ 'imageTextAlternative', '|', 'imageStyle:alignLeft', 'imageStyle:full', 'imageStyle:alignRight' ],

            styles: [
                // This option is equal to a situation where no style is applied.
                'full',

                // This represents an image aligned to the left.
                'alignLeft',

                // This represents an image aligned to the right.
                'alignRight'
            ]
				},
				table: {
					contentToolbar: [
						'tableColumn',
						'tableRow',
						'mergeTableCells'
					]
				},
			} )
			.then( editor => {
				window.editor = editor;
			} )
			.catch( error => {
				console.error( error );
			} );