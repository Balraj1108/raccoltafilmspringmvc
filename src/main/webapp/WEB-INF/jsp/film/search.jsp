<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>

<html lang="it" class="h-100">
	<head>
		<jsp:include page="../header.jsp" />
		
		
		<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css" />
		<style>
			.ui-autocomplete-loading {
				background: white url("../assets/img/jqueryUI/anim_16x16.gif") right center no-repeat;
			}
			.error_field {
		        color: red; 
		    }
		</style>
		
		<title>Ricerca</title>
	</head>
	<body class="d-flex flex-column h-100">
		<jsp:include page="../navbar.jsp" />
		
		<!-- Begin page content -->
		<main class="flex-shrink-0">
		  <div class="container">
		
				<div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none':'' }" role="alert">
				  ${errorMessage}
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
				</div>
				
				
				
				<div class='card'>
				    <div class='card-header'>
				        <h5>Ricerca elementi</h5> 
				    </div>
				    <div class='card-body'>
		
							<form method="post" action="list" class="row g-3">
							
								<div class="col-md-6">
									<label for="titolo" class="form-label">Titolo</label>
									<input type="text" name="titolo" id="titolo" class="form-control" placeholder="Inserire il titolo" >
								</div>
									
								<div class="col-md-6">
									<label for="genere" class="form-label">Genere</label>
									<input type="text" name="genere" id="genere" class="form-control" placeholder="Inserire il genere" >
								</div>
								
								<div class="col-md-6">
									<label for="dataPubblicazione" class="form-label">Data di Pubblicazione</label>
	                        		<input class="form-control" id="dataPubblicazione" type="date" placeholder="dd/MM/yy"
	                            		title="formato : gg/mm/aaaa"  name="dataPubblicazione" >
								</div>
								
								<div class="col-md-6">
									<label for="minutiDurata" class="form-label">Durata (minuti)</label>
									<input type="number" class="form-control" name="minutiDurata" id="minutiDurata" placeholder="Inserire la durata" >
								</div>
								
								<!--  
								  <div class="col-md-6">
									<label for="regista.id" class="form-label">Regista</label>
								    <select class="form-select" id="regista.id" name="regista.id">
								    	<option value=""> -- Selezionare una voce -- </option>
								      	<c:forEach items="${registi_list_attribute}" var="registaItem">
								      		<option value="${registaItem.id}">${registaItem.nome } ${registaItem.cognome }</option>
								      	</c:forEach>
								    </select>
								</div>
									-->
									
								 
								<div class="col-md-6">
										<label for="registaSearchInput" class="form-label">Regista: <span class="text-danger">*</span></label>
											
											<input class="form-control ${status.error ? 'is-invalid' : ''}" type="text" id="registaSearchInput"
												name="registaInput" value="${insert_film_attr.regista.nome}${empty insert_film_attr.regista.nome?'':' '}${insert_film_attr.regista.cognome}">
											
										<input type="hidden" name="regista.id" id="registaId" value="${insert_film_attr.regista.id}">
										<form:errors  path="film" cssClass="error_field" />
								</div>	
									
									
								<div class="col-12">
									<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Conferma</button>
									<input class="btn btn-outline-warning" type="reset" value="Ripulisci">
									<a class="btn btn-outline-primary ml-2" href="${pageContext.request.contextPath }/film/insert">Add New</a>
								</div>
								
							</form>
							
							  
							<%-- FUNZIONE JQUERY UI PER AUTOCOMPLETE --%>
							
								<script>
									$("#registaSearchInput").autocomplete({
										 source: function(request, response) {
										        $.ajax({
										            url: "../regista/searchRegistiAjax",
										            datatype: "json",
										            data: {
										                term: request.term,   
										            },
										            success: function(data) {
										                response($.map(data, function(item) {
										                    return {
											                    label: item.label,
											                    value: item.value
										                    }
										                }))
										            }
										        })
										    },
										//quando seleziono la voce nel campo deve valorizzarsi la descrizione
									    focus: function(event, ui) {
									        $("#registaSearchInput").val(ui.item.label)
									        return false
									    },
									    minLength: 2,
									    //quando seleziono la voce nel campo hidden deve valorizzarsi l'id
									    select: function( event, ui ) {
									    	$('#registaId').val(ui.item.value);
									    	//console.log($('#registaId').val())
									        return false;
									    }
									});
								</script>
								
								<!-- end script autocomplete -->
							
				    
				    
					<!-- end card-body -->			   
				    </div>
				<!-- end card -->
				</div>	
				
			<!-- end container -->
			</div>
		<!-- end main -->	
		</main>
		<jsp:include page="../footer.jsp" />
		
	</body>
</html>