/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/02/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/02/2021  bianca.andrade@moldsoft.com.br         Initial Version
**/
public class ContactUtil {
    public static void validateMask(List<Contact> newContacts){
        for(Contact ctt : newContacts){
            if ((ctt.Phone != null && ctt.Phone != '')){
            	if (Validate.isPhone (ctt.Phone)){
                	ctt.Phone = Validate.imprimePhone (ctt.Phone);
                }else{
                	ctt.Phone.addError ('Neste campo é necessário DDD + Nº telefone (8 ou 9 dígitos).');
                }
            }
        }
    }
}