/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.curso.dao;

import br.com.curso.model.Administrador;
import br.com.curso.model.Cidade;
import br.com.curso.model.Estado;
import br.com.curso.model.Imovel;
import br.com.curso.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author johat
 */
public class ImovelDAO implements GenericDAO{
    private Connection conexao;
    public ImovelDAO() throws Exception{
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
       Boolean retorno = false;
        try{
            Imovel oImovel = (Imovel) objeto;
            if(oImovel.getIdImovel()==0){
                int idImovel = oImovel.getIdImovel();
                if(idImovel==0){
                    retorno = this.inserir(oImovel);
                }else{
                    oImovel.setIdImovel(idImovel);
                    retorno = this.alterar(oImovel);
                }
            }else{
                retorno = this.alterar(oImovel);
            }
        }catch(Exception ex){
            System.out.println("Problemas ao incluir administrador Erro:"+ex.getMessage());
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
         Imovel oImovel = (Imovel) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into imovel ( descricao, endereco, valoraluguel)"
                + " values (?, ?, ?)";
        try{
            
            stmt = conexao.prepareStatement(sql);
            
            stmt.setString(1, oImovel.getDescricao());
            stmt.setString(2, oImovel.getEndereco());
            stmt.setDouble(3, oImovel.getValorAluguel());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try {
                System.out.println("Problemas ao cadastrar Administrador!Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback(); 
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Boolean excluir(int numero) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object carregar(int numero) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql= "Select * from imovel order by idImovel";
                
        try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
          
            while (rs.next()) {
                Imovel oImovel = new Imovel();
                oImovel.setIdImovel(rs.getInt("idImovel"));
                oImovel.setDescricao(rs.getString("descricao"));
                oImovel.setEndereco(rs.getString("endereco"));
                oImovel.setValorAluguel(rs.getDouble("valoraluguel"));
                resultado.add(oImovel);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar Estado! Erro:" + ex.getMessage());
        }
        return resultado;
    }
}
