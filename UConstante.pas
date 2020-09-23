unit UConstante;

interface

const
//Metodos Servidor
   _srv00001 = 'TDaoAgenda.AgendaDisponivel';
   _srv00002 = 'TDaoOrdemServico.GeraOrdemServico';
   _srv00003 = 'TdaoImgCli.DsImgCli';
   _srv00004 = 'TdaoImgCli.IncluirImgCli';
   _srv00005 = 'TdaoImgCli.AlteraImgCli';
   _srv00006 = 'TdaoImgCli.DeletarImgCli';
   _srv00007 = 'TDaoConfiguracao.Configuracao';
   _srv00008 = 'TDaoPermissaoTela.GetPermissaoTela';
   _srv00009 = 'TDaoPermissaoTela.PermissaoTela';
   _srv00010 = 'TDaoPermissaoTela.IncluirPermissaoTela';
   _srv00011 = 'TDaoPermissaoTela.AlteraPermissaoTela';
   _srv00012 = 'TDaoPermissaoTela.DeletarPermissaoTela';
   _srv00013 = 'TDaoUsuario.AlteraUsuario';
   _srv00014 = 'TDaoUsuario.DeletarUsuario';
   _srv00015 = 'TDaoUsuario.IncluirUsuario';
   _srv00016 = 'TDaoUsuario.Usuario';
   _srv00017 = 'TDaoGrupoPessoa.AlteraGrupoPessoa';
   _srv00018 = 'TDaoGrupoPessoa.DeletarGrupoPessoa';
   _srv00019 = 'TDaoGrupoPessoa.GrupoPessoa';
   _srv00020 = 'TDaoGrupoPessoa.IncluirGrupoPessoa';
   _srv00021 = 'TdaoImagem.AlteraImagem';
   _srv00022 = 'TdaoImagem.Imagem';
   _srv00023 = 'TdaoCliente.DsCliente';
   _srv00024 = 'TdaoCliente.IncImgCli';
   _srv00025 = 'TdaoCliente.IncluirCliente';
   _srv00026 = 'TdaoCliente.AlteraCliente';
   _srv00027 = 'TdaoCliente.DeletarCliente';
   _srv00028 = 'TdaoCliente.DelImgCli';
   _srv00029 = 'TdaoCliente.AltImgCli';
   _srv00030 = 'TDaoFormulario.Formulario';
   _srv00031 = 'TDaoFormulario.IncluirFormulario';
   _srv00032 = 'TDaoFormulario.AlteraFormulario';
   _srv00033 = 'TDaoFormulario.DeletarFormulario';
   _srv00034 = 'TdaoEscala.Escala';
   _srv00035 = 'TdaoEscala.AcceptEscala';
   _srv00036 = 'TdaoEscala.UpDateEscala';
   _srv00037 = 'TdaoEscala.CancelEscala';
   _srv00038 = 'TDaoAgenda.Agenda';
   _srv00039 = 'TDaoAgenda.AcceptAgenda';
   _srv00040 = 'TDaoAgenda.UpDateAgenda';
   _srv00041 = 'TDaoAgenda.CancelAgenda';
   _srv00042 = 'TDaoGrupoServico.GrupoServico';
   _srv00043 = 'TDaoGrupoServico.AcceptGrupoServico';
   _srv00044 = 'TDaoGrupoServico.UpDateGrupoServico';
   _srv00045 = 'TDaoGrupoServico.CancelGrupoServico';
   _srv00046 = 'TDaoServico.Servico';
   _srv00047 = 'TDaoServico.AcceptServico';
   _srv00048 = 'TDaoServico.UpDateServico';
   _srv00049 = 'TDaoServico.CancelServico';
   _srv00050 = 'TDaoOrdemServico.OrdemServico';
   _srv00051 = 'TDaoOrdemServico.AcceptOrdemServico';
   _srv00052 = 'TDaoOrdemServico.UpDateOrdemServico';
   _srv00053 = 'TDaoOrdemServico.CancelOrdemServico';
   _srv00054 = 'TDaoOrdemServicoItem.OrdemServicoItem';
   _srv00055 = 'TDaoOrdemServicoItem.AcceptOrdemServicoItem';
   _srv00056 = 'TDaoOrdemServicoItem.UpDateOrdemServicoItem';
   _srv00057 = 'TDaoOrdemServicoItem.CancelOrdemServicoItem';
   _srv00058 = 'TDaoOrdemServicoImg.OrdemServicoImg';
   _srv00059 = 'TDaoOrdemServicoImg.AcceptOrdemServicoImg';
   _srv00060 = 'TDaoOrdemServicoImg.UpDateOrdemServicoImg';
   _srv00061 = 'TDaoOrdemServicoImg.CancelOrdemServicoImg';
   _srv00062 = 'TDaoTelefone.Telefone';
   _srv00063 = 'TDaoTelefone.AcceptTelefone';
   _srv00064 = 'TDaoTelefone.UpDateTelefone';
   _srv00065 = 'TDaoTelefone.CancelTelefone';
   _srv00066 = 'TDaoAgenda.AgendaRel001';
   _srv00067 = '';
   _srv00068 = '';
   _srv00069 = '';
   _srv00070 = '';
   _srv00071 = '';
   _srv00072 = '';
   _srv00073 = '';

//Relatorios
   _rel00001 = 'C:\Gerais\rel001.rav';
   _rel00002 = 'C:\Gerais\rel002.rav';
   _rel00003 = '';
   _rel00004 = '';
   _rel00005 = '';
   _rel00006 = '';
   _rel00007 = '';
   _rel00008 = '';
   _rel00009 = '';
   _rel00010 = '';

//Mensagens
   _msg00001 = 'Registro não pode ser movimentado!'+char(10)+'("Status" diferente de "%s")';
   _msg00002 = 'Erro ao localiza "%s" no campo "%s"!';
   _msg00003 = 'Localiza %s: ';
   _msg00004 = 'Código não localizado!';
   _msg00005 = 'Confirmar exclusão?';
   _msg00006 = 'Error Serviço DataSnep; ';
   _msg00007 = 'Operação cancelada.';
   _msg00008 = 'Código não localizado!';
   _msg00009 = 'Registro inexistente para alteração!';
   _msg00010 = '#000000';
   _msg00011 = '#,##0.00';
   _msg00012 = 'Error Consusta: ';
   _msg00013 = 'Qtd. Registros: ';
   _msg00014 = 'Error Consusta Serviço Rest: ';
   _msg00015 = 'Arquivo fisico inexistente!';
   _msg00016 = 'http://localhost/datasnap/rest/TdaoImagemRest/Imagem/';
   _msg00017 = 'C:/Gerais/';
   _msg00018 = 'Campo vazio!';
   _msg00019 = 'https://web.whatsapp.com/send?phone=%s&text=%s';
   _msg00020 = 'Ola %s! %s';
   _msg00021 = 'Segue agendamento para o dia %s as %s. Favor chega 10 minutos antes do horário agendado. Obrigado!';
   _msg00022 = 'DEFAULT_ORDER';
   _msg00023 = '';
   _msg00024 = '';
   _msg00025 = '';
   _msg00026 = '';
   _msg00027 = '';
   _msg00028 = '';
   _msg00029 = '';
   _msg00030 = '';


implementation

end.
