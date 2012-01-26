function parse_org_styles_net(json){
  ret = {
    nodes:[],
    links:[]
  }
}

function parse_org_styles(json){
  var ret = {
    name: "Organization Styles",
    children:[]
  }
  for(i in json){
    var new_org_style = {name: json[i].org_style.name, children:[]}
    for(j in json[i].org_style.op_birds){
      var new_bird = {
        name: json[i].org_style.op_birds[j].name,
        size:  word_count(json[i].genus_type.birds[j]),
        path: json[i].org_style.op_birds[j].path

      }
      new_org_style.children.push(new_bird)
    }    
    ret.children.push(new_org_style)
  }
  return ret;
}


function parse_json(json, field, title){
  var ret = {
    name: title,
    children:[]
  }
  for(i in json){
    var new_org_style = {name: json[i][field].name, children:[]}
    for(j in json[i][field].birds){
      var new_bird = {
        name: json[i][field].birds[j].name,
        size:  bird_count(json[i][field].birds[j]),
        path: json[i][field].birds[j].path

      }
      new_org_style.children.push(new_bird)
    } 
    ret.children.push(new_org_style)
  }
  return ret;
}

function word_count(d) {
  if(d == null){
    return 0;
  }else if (typeof d == "string"){
    return d.split(/\s+/).length
  } else if (typeof d == "number"){
    return 1;
  } else if(d instanceof Array){
    var count = 0;
    var i = 0;
    for(;i<d.length;++i){
      count += word_count(d[i])
    }
    return count;
  }
  return 0;
}

function bird_count(bird){
  var count = 0;
  for(var f in bird){
    count += word_count(bird[f])
  }
  return count;
}
