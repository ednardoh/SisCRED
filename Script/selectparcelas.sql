select * from tb_parcelas;
select * from tb_clientes;
select * from tb_credores;
select * from tb_tipopgto;


select c.CPF, 
       c.nome as NomeCLiente, 
	   cr.cpf_cnpj, 
	   cr.nome as RazaoSocialcredor,
	   tp.tipopgto,
	   p.valor_total,
	   p.dt_primeira_parcela,
	   case when tp.tipopgto <> 'A VISTA' then
	     (CURRENT_DATE-TO_DATE(p.dt_primeira_parcela,'dd/mm/yyyy')) 
	   else
	     0
	   end AS Qdiaspriparc,	
	   case when (case when (tp.tipopgto <> 'A VISTA' and p.dt_primeira_parcela <> '') then
					 (CURRENT_DATE-TO_DATE(p.dt_primeira_parcela,'dd/mm/yyyy')) 
				   else
					 0
				   end) > 0 then
	     'Em Atraso'
	   else
	     'Em Dia'
	   end as Statuspriparc,	 
	   p.vl_primeira_parcela,	   
	   p.dt_segunda_parcela,
	   case when (tp.tipopgto <> 'A VISTA' and p.dt_segunda_parcela <> '') then
	     (CURRENT_DATE-TO_DATE(p.dt_segunda_parcela,'dd/mm/yyyy')) 
	   else
	     0
	   end AS Qdiassegparc,	
       case when (case when (tp.tipopgto <> 'A VISTA' and p.dt_segunda_parcela <> '') then
					 (CURRENT_DATE-TO_DATE(p.dt_segunda_parcela,'dd/mm/yyyy')) 
				   else
					 0
				   end) > 0 then
	     'Em Atraso'
	   else
	     'Em Dia'
	   end as Statussegparc,	   
	   p.vl_segunda_parcela,
	   p.dt_terceira_parcela,
       case when (tp.tipopgto <> 'A VISTA' and p.dt_terceira_parcela <> '') then
	     (CURRENT_DATE-TO_DATE(p.dt_terceira_parcela,'dd/mm/yyyy')) 
	   else
	     0
	   end AS Qdiasterparc,	
       case when (case when (tp.tipopgto <> 'A VISTA' and p.dt_terceira_parcela <> '') then
					 (CURRENT_DATE-TO_DATE(p.dt_terceira_parcela,'dd/mm/yyyy')) 
				   else
					 0
				   end) > 0 then
	     'Em Atraso'
	   else
	     'Em Dia'
	   end as Statusterparc,	   
	   p.vl_terceira_parcela,
	   p.dt_quarta_parcela,
       case when (tp.tipopgto <> 'A VISTA' and p.dt_quarta_parcela <> '') then
	     (CURRENT_DATE-TO_DATE(p.dt_quarta_parcela,'dd/mm/yyyy')) 
	   else
	     0
	   end AS Qdiasquaparc,	 
       case when (case when (tp.tipopgto <> 'A VISTA' and p.dt_quarta_parcela <> '') then
					 (CURRENT_DATE-TO_DATE(p.dt_quarta_parcela,'dd/mm/yyyy')) 
				   else
					 0
				   end) > 0 then
	     'Em Atraso'
	   else
	     'Em Dia'
	   end as Statusquaparc,	   
	   p.vl_quarta_parcela
from tb_parcelas p
inner join tb_clientes c on c.id = p.id_cliente
inner join tb_credores cr on cr.id = p.id_credor
inner join tb_tipopgto tp on tp.id = p.id_tipo_pgto
where tp.tipopgto <> 'A VISTA'
  and c.cpf = '17503952075';