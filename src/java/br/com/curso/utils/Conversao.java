/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.curso.utils;


import java.sql.Date;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;


/**
 *
 * @author johat
 */
public class Conversao {
    public static Date converterData(String data) throws ParseException{
        SimpleDateFormat fmt = new SimpleDateFormat ("yyyy-MM-dd");
        if(data == null || data.trim().equals("")){
            return null;
        }else{
            Date date =  (Date) fmt.parse(data);
            return date;
        }
    }
    
    public static String data2String(Date date){
        SimpleDateFormat fmt = new SimpleDateFormat ("dd/MM/yyyy");
        String dataFormatada = fmt.format(date);
        return dataFormatada;
    }
    
    public static Date dataAtual(){
        SimpleDateFormat fmt = new SimpleDateFormat ("dd/MM/yyyy");
        Date novaData = new Date(System.currentTimeMillis());
        return novaData;
    }
    
    public static double valorDinheiro(String valor){
        String conversao = valor.substring(2, valor.length());
        conversao = conversao.replaceAll("./-", "");
        conversao = conversao.replace(",", ".");
        return Double.parseDouble(conversao);
    }
    
    public static String valorDinheiro(double valor, String pais){
        NumberFormat formatter = null;
        if (pais.equals("BR")){
            formatter = NumberFormat.getCurrencyInstance();
        }else if(pais.equals("US")){
            formatter = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
        }
        String moneyString = formatter.format(valor);
        return moneyString;
    }
}
