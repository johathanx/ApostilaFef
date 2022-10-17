<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<jsp:include page="/header.jsp"/>
<jsp:include page="/cadastros/menuLogado.jsp"/>

<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Imovel</h1>
    <p class="mb-4">Planilha de Registros</p>
    <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" 
              data-id="" onclick="setDadosModal(${0})">
        <i class="fas fa-plus fa-fw"></i> Adicionar </a>
    <div class="card shadow">
        <div class="card-body">
            <table id="datatable" class="display">
                <thead>
                    <tr>
                        <th align="center">ID</th>
                        <th align="center">Descrição</th>
                        <th align="center">Endereço</th>
                        <th align="center">Valor do Aluguel</th>
                        <th Align="center">Alterar</th>
                        <th Align="center">Excluir</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="imovel" items="${imoveis}">                    
                        <tr>
                            <td align="center">${imovel.idImovel}</td>                    
                            <td align="center">${imovel.descricao}</td>
                            <td align="center">${imovel.endereco}</td>
                       <td align="center">${imovel.valorAluguel}</td>
                            <td align="center">
                                <a href="#modaladicionar" class="btn btn-success adicionar" data-toggle="modal" 
                                   data-id="" onclick="setDadosModal(${imovel.idImovel})">
                                    <i class="fas fa-plus fa-fw"></i> Alterar </a>
                            </td>
                            <td align="center">
                                <a href="#" onclick="deletar(${administrador.idAdministrador})">
                                    <button class="btn 
                                          <c:out value="${administrador.situacao == 'A' ? 'btn-danger': 'btn-success'}"/>">
                                        <i class="fas fa-fw 
                                           <c:out value="${administrador.situacao == 'A' ? 'fa-times' : ' fa-plus'}"/>"></i>
                                        <Strong>
                                            <c:out value="${administrador.situacao == 'A' ? 'Inativar': 'Ativar'}"/>
                                        </Strong>
                                    </button></a>
                            </td>
                        </tr>                
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
        
    <div class="modal fade" id="modaladicionar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Adicionar</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    
                  
                    <div class="form-group">
                        
                        <input class="form-control" type="text" name="idimovel" id="idimovel" 
                               value="" readonly="readonly"/>
                    </div>

                    <div class="form-group">
                        <label>Descrição</label>
                        <input class="form-control" type="text" name="descricao" id="descricao" 
                               value=""/>
                    </div>
                    <div class="form-group">
                        <label>Endereço</label>
                        <input class="form-control" type="text" name="endereco" id="endereco" 
                               value=""/>
                    </div>


                    <div class="form-group">
                        <label>Valor do Aluguel</label>
                        <input class="form-control" type="text" name="valoraluguel" id="valoraluguel"/>
                    </div>

                    

                    

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <a href="#" onclick="validarCampos()">
                            <button type="button" class="btn btn-success">Salvar</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>        
</div>   

 <style type="text/css">
    .inputfile {
        /* visibility: hidden etc. wont work */
        width: 0.1px;
        height: 0.1px;
        opacity: 0;
        overflow: hidden;
        position: absolute;
        z-index: -1;
    }
    .inputfile:focus + label {
        /* keyboard navigation */
        outline: 1px dotted #000;
        outline: -webkit-focus-ring-color auto 5px;
    }
    .inputfile + label * {
        pointer-events: none;
    }
    .borda{
        position: relative;
        margin: 0 20px 30px 0;
        padding: 10px;
        border: 1px solid #e1e1e1;
        border-radius: 3px;
        background: #fff;
        -webkit-box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
        -moz-box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
        box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
    }
</style>                                        
                                        
<script>
    $(document).ready(function() {
            console.log('entrei ready');
            //Carregamos a datatable
            //$("#datatable").DataTable({});
            $('#datatable').DataTable({
                "oLanguage": {
                    "sProcessing": "Processando...",
                    "sLengthMenu": "Mostrar _MENU_ registros",
                    "sZeroRecords": "Nenhum registro encontrado.",
                    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                    "sInfoEmpty": "Mostrando de 0 até 0 de 0 registros",
                    "sInfoFiltered": "",
                    "sInfoPostFix": "",
                    "sSearch": "Buscar:",
                    "sUrl": "",
                    "oPaginate": {
                        "sFirst": "Primeiro",
                        "sPrevious": "Anterior",
                        "sNext": "Seguinte",
                        "sLast": "Último"
                    }
                }
            });
        });
    
    var cidade = ''; //variavel para controle do carregamento de cidades.
    function limparDadosModal(){
        $('#idimovel').val("0");
        $('#descricao').val("");
        $('#endereco').val("");
        $('#valoraluguel').val("0");
        
    }
    
    function setDadosModal(valor) {
        limparDadosModal();
        
        
        document.getElementById('idimovel').value = valor;
        var idImo = valor;
        if (idImo != "0"){
            //existe administrador para buscar (alteração)
            $.getJSON('ImovelCarregar', {idAdministrador: idAdm}, function(respostaServlet){
                console.log(respostaServlet);
                var id = respostaServlet.idAdministrador;
                if(id != "0"){
                    $('#idpessoa').val(respostaServlet.idPessoa);
                    $('#idadministrador').val(respostaServlet.idAdministrador);
                    $('#situacao').val(respostaServlet.situacao);
                    $('#cpfcnpjpessoa').val(respostaServlet.cpfCnpj);
                    $('#nomepessoa').val(respostaServlet.nome);
                    $('#datanascimento').val(respostaServlet.dataNascimento);
                    $('#idestado').val(respostaServlet.cidade.estado.idEstado);
                    cidade = respostaServlet.cidade.idCidade;
                    BuscarCidadesPorEstado(); //atualiza lista de cidades
                    $('#login').val(respostaServlet.login);
                    $('#senha').val(respostaServlet.senha);
                    $('#permitelogin').val(respostaServlet.permiteLogin);
                    foto.src = respostaServlet.foto;
                }
            });
        }
    }
    
    function carregarPessoa(v) {
        //console.log("Entrou");
        var idM = v;
        var tipoPessoa = 'administrador';
        //console.log("Usuario = " + idM);
        $(document).ready(function () {
            $.getJSON('PessoaBuscarCpfCnpj', {cpfcnpjpessoa: idM, tipopessoa: tipoPessoa}, function (respostaAdm) {
                console.log(respostaAdm);
                //var id = respostaAdm.idAdministrador;
                if (respostaAdm != null)
                {
                    $('#idadministrador').val(respostaAdm.idAdministrador);
                    $('#permitelogin').val(respostaAdm.permiteLogin);
                    $('#situacao').val(respostaAdm.situacao);
                    $('#idpessoa').val(respostaAdm.idPessoa);
                    $('#nomepessoa').val(respostaAdm.nome);
                    $('#login').val(respostaAdm.login);
                    var datanasc = respostaAdm.dataNascimento;
                    console.log(datanasc);
                    $('#datanascimento').val(datanasc);
                    $('#idestado').val(respostaAdm.cidade.estado.idEstado);
                    cidade = respostaAdm.cidade.idCidade;
                    BuscarCidadesPorEstado();
                    var foto = document.getElementById("foto");                    
                    foto.src = respostaAdm.foto;
                } else {
                    //se não encontrou administrador busca por pessoa somente
                    tipoPessoa = 'pessoa';
                    $.getJSON('PessoaBuscarCpfCnpj', {cpfcnpjpessoa: idM, tipopessoa: tipoPessoa}, function (respostaPessoa) {
                        console.log(respostaPessoa);
                        var id = respostaPessoa.idPessoa;
                        if (id != "0")
                        {
                            $('#idpessoa').val(respostaPessoa.idPessoa);
                            $('#nomepessoa').val(respostaPessoa.nome);
                            $('#login').val(respostaPessoa.login);
                            var datanasc = respostaPessoa.dataNascimento;
                            console.log(datanasc);
                            $('#datanascimento').val(datanasc);
                            $('#idestado').val(respostaPessoa.cidade.estado.idEstado);
                            cidade = respostaPessoa.cidade.idCidade;
                            BuscarCidadesPorEstado();
                            var foto = document.getElementById("foto");                    
                            foto.src = respostaPessoa.foto;
                        }
                    });
                }
            });
        });
    }
    
    function deletar(codigo){
        var id = codigo;
        console.log(codigo);
        Swal.fire({
            title: 'Você tem certeza?',
            text: "Você deseja realmente inativar/ativar o administrador?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/AdministradorExcluir',
                    data:{
                        idAdministrador: id
                    },
                    success:
                        function(data){
                            if(data == 1){
                                Swal.fire({
                                    position: 'top-end',
                                    icon: 'success',
                                    title: 'Sucesso',
                                    text: 'Administrdor inativado com sucesso!',
                                    showConfirmButton: true,
                                    timer: 10000
                                }).then(function(){
                                    window.location.href = "${pageContext.request.contextPath}/AdministradorListar";
                                })
                            } else {
                                Swal.fire({
                                    position: 'top-end',
                                    icon: 'error',
                                    title: 'Erro',
                                    text: 'Não foi possível inativar administrador!',
                                    showConfirmButton: true,
                                    timer: 10000
                                }).then(function(){
                                    window.location.href = "${pageContext.request.contextPath}/AdministradorListar";
                                })
                            }
                        },
                    error:
                        function(data){
                            window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                        }
                });
            };
        });
    }
    
    function validarCampos() {
        console.log("entrei na validação de campos");
        if (document.getElementById("descricao").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o Nome do Administrador!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#nome").focus();
        } else if (document.getElementById("endereco").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a Data de nascimento!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#datanascimento").focus();
        } else if (document.getElementById("valoraluguel").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a cidade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else {
            gravarDados();
        }
    }
    function gravarDados() {
        console.log("Gravando dados ....");
        
        $.ajax({
            type: 'post',
            url: 'ImovelCadastrar',
            data: {
                idimovel: $('#idimovel').val(),
                descricao: $('#descricao').val(),
                endereco: $('#endereco').unmask().val(),
                valoraluguel: $('#valoraluguel').val()
                
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Administrador gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/ImovelListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o administrador!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/ImovelListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/ImovelListar";
                    }
        });
    }
    
    function BuscarCidadesPorEstado(){
        $('#idcidade').empty();
        idEst = $('#idestado').val();
        console.log("entrou buscar estado");
        if (idEst != 'null')
        {
            console.log("estado = " + idEst);
            url = "CidadeBuscarPorEstado?idestado=" + idEst;
            //console.log(url);
            $.getJSON(url, function (result) {
                //alert(result);
                $.each(result, function (index, value) {
                    $('#idcidade').append('<option id="cidade_' + value.idCidade + '"value="' + value.idCidade + '">' + 
                            value.nomeCidade + '</option>');
                    if (cidade !== '') {
                        $('#cidade_' + cidade).prop({selected: true});
                    } else {
                        $('#cidade_').prop({selected: true});
                    }
                });
            }).fail(function (obj, textStatus, error) {
                alert('Erro do servidor: ' + textStatus + ', ' + error);
            });
        }
    }
    
    function uploadFile() {
        var target = document.getElementById("foto");
        target.src = "";
        var file = document.querySelector("input[type='file']").files[0];
        if (file) {
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function () {
                target.src = reader.result;
            };
        } else {
            target.src = "";
        }
    }
</script>
 <%@include file="/footer.jsp"%>
