$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();

    //放大聊天列表視窗
    $(".chatHeader").click(function(e){
       $(".chatContainer").toggleClass("chatWindow"); 
    });

    //點選建立聊天的圖示，會跳出建立聊天的小視窗
    $("#chat_addFri_span").click(function(e){
        $("#chat_AddFri_Modal").modal({backdrop:'static'});
        $("#chatName").css("border-color",""); //清除若聊天室未輸入所設定的紅框
        e.stopPropagation();
    });

    //聊天對話小視窗中的搜尋好友
    $("#search_Fri").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("div.chatContext>ul.list-group > li.list-group-item").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

    //建立聊天對話中的搜尋好友清單
    $("#search_Fri_modal").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#chat_AddFri_Modal .modal-body div.item").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

    //建立聊天對話選取好友的效果
    $("input[type='checkbox']").on("change", function() {
        if(this.checked){
            var img_src=$(this).next().children("img").attr('src');
            var fri_name=$(this).next().children("span").text();
            var str="<div class='item'><img class='ui avatar image' src='"+img_src+"'><span class='content'>"+fri_name+"</span></div>";
            $("#select_FriList").append(str);
        }else{
            var img_src=$(this).next().children("img").attr('src');
            $("#select_FriList img[src='"+img_src+"']").parent().remove();     
        }
    });

    //建立聊天對話視窗後，取消時都會把以勾選的checkboix設定未選擇狀況及輸入盒清空
    $(".modal-footer>button[data-dismiss='modal']").click(function(){
         $("input[type='checkbox']").removeAttr("checked");
         $("#search_Fri_modal").val("");
         $("#chatName").val("");
         $("#select_FriList").empty();
    });

    //建立聊天對話視窗後，確認時會把聊天名、參加名單送出，再把原表單內容清空
    $(".modal-footer>button[class='btn btn-success']").click(function(){
         /*這邊要抓到選取的資料，送到資料庫新增Table*/
         if($("#chatName").val() == ""){
             alert("請填寫聊天對話名稱");
             $("#chatName").css("border-color","red");
         }else{
             alert("我這邊要抓到聊天名、參加名單");
             $("input[type='checkbox']").removeAttr("checked");
             $("#search_Fri_modal").val("");
             $("#chatName").val("");
             $("#select_FriList").empty();
             $("#chat_AddFri_Modal").modal('toggle');
         }

    });

});
