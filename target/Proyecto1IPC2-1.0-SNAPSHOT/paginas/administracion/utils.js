/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function agregarId(tiposPiezas) {
    var li = document.createElement("LI");
    var div = document.createElement("div");
    var span1 = document.createElement("span");
    var span2 = document.createElement("span");
    var select = document.createElement("select");
    var input = document.createElement("input");
    var cantidadElementos = document.getElementById("lista-id").getElementsByTagName("li").length;
    li.id = "li" + cantidadElementos;
    li.name = "li" + cantidadElementos;
    li.className = "list-group-item mx-auto";

    div.className = "input-group mb-3";

    span1.className = "input-group-text";
    span1.id = "tipo-label" + cantidadElementos;
    span1.innerHTML = "Tipo Pieza";
    
    //<span class="input-group-text" id="cantidad-label0">Cantidad Pieza</span>

    span2.className = "input-group-text";
    span2.id = "cantidad-label" + cantidadElementos;
    span2.innerHTML = "Cantidad Pieza";

    select.className = "form-select";
    select.id = "tipo" + cantidadElementos;
    select.name = "tipo" + cantidadElementos;
    select.required = true;
    
    //<input type="number" class="form-control" id="cantidad0" name="cantidad0" required>
    input.type = "number";
    input.className = "form-control";
    input.id = "cantidad" + cantidadElementos;
    input.name = "cantidad" + cantidadElementos;
    input.min = 1;
    input.required = true;
    
    var optionDefault = document.createElement("option");
        
    optionDefault.selected = true;
    optionDefault.disabled = true;
    optionDefault.value = "";
    optionDefault.textContent = "Elije un tipo de pieza...";
    
    select.appendChild(optionDefault);

    for (let i = 0; i < tiposPiezas.length; i++) {
        console.log(tiposPiezas[i]);
        var option = document.createElement("option");
                
        option.value = tiposPiezas[i];
        option.textContent = tiposPiezas[i];
        
        select.appendChild(option);
    }

    li.appendChild(div);
    div.appendChild(span1);
    div.appendChild(select);
    div.appendChild(span2);
    div.appendChild(input);
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

