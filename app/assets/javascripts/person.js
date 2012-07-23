/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
        $(function() {
		function log( message ) {
			$( "<div/>" ).text( message ).prependTo( "#log" );
			$( "#log" ).scrollTop( 0 );
		}

		$( "#per_surname" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/pers/surnamesearch",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data, function( item ) {
							return {
								label: item.surname,
								value: item.surname
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
	
        
		$( "#per_name" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/pers/namesearch",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data, function( item ) {
							return {
								label: item.name,
								value: item.name
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


		$( "#per_midname" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/pers/midnamesearch",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data, function( item ) {
							return {
								label: item.midname,
								value: item.midname
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

		$( "#per_family" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "/pers/familysearch",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data, function( item ) {
							return {
								label: item.family,
								value: item.family
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