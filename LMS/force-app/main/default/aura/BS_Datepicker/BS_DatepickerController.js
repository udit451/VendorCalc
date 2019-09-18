/**
 * Created by Rajat on 3/9/2018.
 */
({
    doInit : function(c, e, h){
        $(document).ready(function(){
            var date_input=$('input[name="date"]'); //our date input has the name "date"
            var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
            date_input.datepicker({
                format: 'dd/mm/yyyy',
                container: '#myModalId',
                todayHighlight: true,
                autoclose: true,
                orientation: 'top',

            })
        });
        /////////////////////
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!

        var yyyy = today.getFullYear();
        if(dd<10){
            dd='0'+dd;
        }
        if(mm<10){
            mm='0'+mm;
        }
        var today = dd+'/'+mm+'/'+yyyy;
        $("input:text").val(today);
        var date = new Date(yyyy,mm,dd);
        var dateValue = date,
            mnth = ("0" + (date.getMonth())).slice(-2),
            day  = ("0" + date.getDate()).slice(-2);
        dateValue = [ date.getFullYear(), mnth, day].join("-");
        //console.log(dateValue);
        c.set("v.value", dateValue);
        //////////////////////
        $("input").change(function(){
            var dateSelect = $('#Datepicker_'+c.get("v.idPrefix")).val();
            var DList = dateSelect.split('/');
            var date = new Date(DList[2],DList[1],DList[0]);
            var dateValue = date,
                mnth = ("0" + (date.getMonth())).slice(-2),
                day  = ("0" + date.getDate()).slice(-2);
            dateValue = [ date.getFullYear(), mnth, day].join("-");
            //console.log(dateValue);
            c.set("v.value", dateValue);
        });
    },
})