module todo_list::todo_list;

use std::string::String;

public struct  TodoList has key, store {
  id: UID,
  items: vector<String>
}

public fun new(ctx: &mut TxContext): TodoList{
   let list = TodoList {
    id: object::new(ctx),
    items: vector[]
   };

   (list)

}

public fun add(list: &mut TodoList, item: String){
   list.items.push_back(item);
}


