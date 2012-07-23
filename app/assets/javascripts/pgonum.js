/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
        $(function() {


    $("#surname_surname").click(function () {
        $( "#searchinput" ).val("");

        $( "#pgo-id" ).val(-1)
        tt();
    });

    $("#surname_address").click(function () {
        $( "#searchinput" ).val("");

        $( "#pgo-id" ).val(-1)
        tt();
    });

    $("#surname_number").click(function () {
        $( "#searchinput" ).val("");

        $( "#pgo-id" ).val(-1)
        tt();
    });
    
   $(tt = function() {
      var rSur = $('#surname_surname').is(':checked');
      var rAdre = $('#surname_address').is(':checked');
      var rPgo = $('#surname_number').is(':checked');

 if (rSur) {
		$( "#searchinput" ).autocomplete({
                                 minLength: 2,
             delay: 400,
                        search: function(event, ui) { 
                        $( "#pgo-id" ).val(-1)
                    
                },   
			source: function( request, response ) {
				$.ajax({
					url: "/allpgo/searchsur",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
                                      if ( $.isEmptyObject(data)) {
                                         
                                      response(new Array({
								label: "\u0416\u043e\u0434\u043d\u0438\u0439 \u0437\u0430\u043f\u0438\u0441 \u043d\u0435 \u043c\u0456\u0441\u0442\u0438\u0442\u044c \u0432\u0430\u0448\u043e\u0433\u043e \u0437\u0430\u043f\u0440\u043e\u0441\u0443",
								value: "\u0416\u043e\u0434\u043d\u0438\u0439 \u0437\u0430\u043f\u0438\u0441 \u043d\u0435 \u043c\u0456\u0441\u0442\u0438\u0442\u044c \u0432\u0430\u0448\u043e\u0433\u043e \u0437\u0430\u043f\u0440\u043e\u0441\u0443",
                                                                desc:  "",
                                                                id: -1
							}))}
                                      else {
                                     

						response( $.map( data, function( item ) {
							return {
								label: item.fullname,
								value: item.fullname,
                                                                desc:  item.fulladdres + "; № " + item.num_1  + "-" + item.num_2,
                                                                id: item.id
							}
						}));}
					}
				});
			},
			
			select: function( event, ui ) {
                            $( "#pgo-id" ).val( ui.item.id );

			},
			open: function() {
                            
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
                                
			},
			close: function( event, ui) {
				

                               $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
		})    		.data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
				.data( "item.autocomplete", item )
				.append( "<a>" + item.label + "<div class='comment'>" + item.desc + "</div></a>" )
				.appendTo( ul );
		};    
      
                
                
	}
   
   
   if (rAdre) {
       
		$( "#searchinput" ).autocomplete({
                                 minLength: 4,
             delay: 400,
                        search: function(event, ui) { 
                        $( "#pgo-id" ).val(-1)
                    
                },  
                source: function( request, response ) {
				$.ajax({
					url: "/allpgo/searchadre",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
                     if ( $.isEmptyObject(data)) {
                                         
                                      response(new Array({
								label: "\u0416\u043e\u0434\u043d\u0438\u0439 \u0437\u0430\u043f\u0438\u0441 \u043d\u0435 \u043c\u0456\u0441\u0442\u0438\u0442\u044c \u0432\u0430\u0448\u043e\u0433\u043e \u0437\u0430\u043f\u0440\u043e\u0441\u0443",
								value: "\u0416\u043e\u0434\u043d\u0438\u0439 \u0437\u0430\u043f\u0438\u0441 \u043d\u0435 \u043c\u0456\u0441\u0442\u0438\u0442\u044c \u0432\u0430\u0448\u043e\u0433\u043e \u0437\u0430\u043f\u0440\u043e\u0441\u0443",

                                                                desc:  "",
                                                                id: -1
							}))}
                                      else {                         
                    

						response( $.map( data, function( item ) {
							return {
								label: item.fulladdres ,
								value: item.adrquest ,
                                                                desc: item.fullname + " " + '; № ' + item.num_1  +"-" + item.num_2 ,
                                                                  id: item.id
							}
						})); }
					}
				});
			},
		
			select: function( event, ui ) {
                            $( "#pgo-id" ).val( ui.item.id );

			},
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {

				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
                        
                        
                        
		})
            
    		.data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
				.data( "item.autocomplete", item )
				.append( "<a>" + item.label + "<div class='comment'>" + item.desc + "</div></a>" )
				.appendTo( ul );
		};    
      
                
                
	}

if (rPgo) {
		$( "#searchinput" ).autocomplete({
                                 minLength: 1,
             delay: 400,
                        search: function(event, ui) { 
                        $( "#pgo-id" ).val(-1)
                    
                },               
			source: function( request, response ) {
				$.ajax({
					url: "/allpgo/searchnum",
					dataType: "jsonp",
					data: { query: request.term,
		
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
                     if ( $.isEmptyObject(data)) {
                                      response(new Array({
								label: "\u0416\u043e\u0434\u043d\u0438\u0439 \u0437\u0430\u043f\u0438\u0441 \u043d\u0435 \u043c\u0456\u0441\u0442\u0438\u0442\u044c \u0432\u0430\u0448\u043e\u0433\u043e \u0437\u0430\u043f\u0440\u043e\u0441\u0443",
								value: "\u0416\u043e\u0434\u043d\u0438\u0439 \u0437\u0430\u043f\u0438\u0441 \u043d\u0435 \u043c\u0456\u0441\u0442\u0438\u0442\u044c \u0432\u0430\u0448\u043e\u0433\u043e \u0437\u0430\u043f\u0440\u043e\u0441\u0443",

                                                                desc:  "",
                                                                id: -1
							}))}
                                      else { 
                                            
						response( $.map( data, function( item ) {
							return {
								label: item.num_1  +"-" + item.num_2, 
								value: item.num_1  +"-" + item.num_2,
                                                                desc: item.fullname + " " + "; "  + item.fulladdres,
                                                                id: item.id                                                                
							}
						}));}
					}
				});
			},
	
			select: function( event, ui ) {
                                   $( "#pgo-id" ).val( ui.item.id );

			},
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {

				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
		})    		.data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
				.data( "item.autocomplete", item )
				.append( "<a>" + item.label + "<div class='comment'>" + item.desc + "</div></a>" )
				.appendTo( ul );
		};    
      
                
                
	}
});
        
        });  

