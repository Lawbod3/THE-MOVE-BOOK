module todo_list::todo_list_test {
    use todo_list::todo_list;
    use todo_list::todo_list::TodoList;
    use std::unit_test as ut;
    use sui::test_scenario;
    use sui::kiosk::list;
   
    

    #[test]
    public fun test_create_todoList_is_empty() {
        let admin = @0xA;
        let mut scenario = test_scenario::begin(admin);

        // Transaction 1: create and persist TodoList
        {
            let list = todo_list::new(scenario.ctx());
            transfer::public_transfer(list, admin); // consume `list`
        };

        // Transaction 2: fetch and inspect
        scenario.next_tx(admin);
        {
            let list = scenario.take_from_sender<TodoList>();
            ut::assert_eq !(todo_list::length(&list), 0);

            scenario.return_to_sender(list); // consume `list`
        };

        scenario.end(); // consume `scenario`
    }

    #[test]
    public fun test_todoList_can_add(){
        let admin = @0xA;
        let mut scenario = test_scenario::begin(admin);

        {
           let list = todo_list::new(scenario.ctx());
           transfer::public_transfer(list, admin );
        };

        scenario.next_tx(admin);
        {
          let mut list = scenario.take_from_sender<TodoList>();
          todo_list::add(&mut list, b"item".to_string());
          ut::assert_eq!(todo_list::length(&list), 1);
          
          scenario.return_to_sender(list);
        };
         scenario.end();
    }

    #[test]
    public fun test_todoList_can_remove(){
        let admin = @0xA;
        let mut scenario = test_scenario::begin(admin);

        {
           let list = todo_list::new(scenario.ctx());
           transfer::public_transfer(list, admin );
        };

        scenario.next_tx(admin);
        {
          let mut list = scenario.take_from_sender<TodoList>();
          todo_list::add(&mut list, b"item".to_string());
          ut::assert_eq!(todo_list::length(&list), 1);
          
          todo_list::remove(&mut list, 0);
          ut::assert_eq!(todo_list::length(&list), 0);
        
          scenario.return_to_sender(list);
        };
         scenario.end();
    }
}


