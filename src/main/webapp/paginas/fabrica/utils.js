/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function agregarId() {
    var li = document.createElement("LI");
    var input = document.createElement("input");
    var cantidadElementos = document.getElementById("lista-id").getElementsByTagName("li").length;
    li.id = "idLi" + cantidadElementos;
    li.name = "idLi" + cantidadElementos;
    li.className = "list-group-item mx-auto";

    input.type = "number";
    input.name = "id" + cantidadElementos;
    input.id = "id" + cantidadElementos;
    input.required = true;

    li.appendChild(input);
    document.getElementById("lista-id").appendChild(li);
}

function removerId() {
    var cantidadElementos = document.getElementById("lista-id").getElementsByTagName("li").length;

    if (cantidadElementos > 1) {
        var listaId = document.getElementById("lista-id").getElementsByTagName("li");
        var last = listaId[listaId.length - 1];
        last.parentNode.removeChild(last);
    }
}

