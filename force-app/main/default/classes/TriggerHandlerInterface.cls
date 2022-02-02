/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/01/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/01/2021  bianca.andrade@moldsoft.com.br         Initial Version
**/
global interface TriggerHandlerInterface {

    void beforeUpdate();
    
    void beforeInsert();
    
    void beforeDelete();
    
    void afterUpdate();
    
    void afterInsert();
    
    void afterDelete();
}