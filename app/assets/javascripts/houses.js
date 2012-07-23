/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
        $(function() {
		function log( message ) {
			$( "<div/>" ).text( message ).prependTo( "#log" );
			$( "#log" ).scrollTop( 0 );
		}

		$( "#house_material_wall" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/houses/wallsearch",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data, function( item ) {
							return {
								label: item.material_wall,
								value: item.material_wall
							}
						}));
					}
				});
			},
			minLength: 1,
			select: function( event, ui ) {
				log( ui.item ?
					"Selected: " + ui.item.label :
					"Nothing selected, input was " + this.value);
			},
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {
				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
		});
	
        
		$( "#house_material_krovl" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/houses/krovlsearch",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data, function( item ) {
							return {
								label: item.material_krovl,
								value: item.material_krovl
							}
						}));
					}
				});
			},
			minLength: 1,
			select: function( event, ui ) {
				log( ui.item ?
					"Selected: " + ui.item.label :
					"Nothing selected, input was " + this.value);
			},
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {
				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
		});


		
});