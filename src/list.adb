package body List is

   -- Initialize a list
   procedure Init(List : out T_List) is
   begin
      List.Size := 0;
   end Init;

   -- Add an element to the list
   procedure Add(List : in out T_List; Element : in T_Type) is
   begin
        List.Size := List.Size + 1;
        List.Content(List.Size) := Element;
   end Add;

   -- Delete the last element of the list
   procedure Delete(List : in out T_List; Index : in Natural) is
   begin
        for I in Index..(List.Size-1) loop
            List.Content(I) := List.Content(I+1);
        end loop;
        List.Size := List.Size - 1;
   end Delete;

   -- Modify an element of the list
   procedure Modify(List : in out T_List; Element : in T_Type; Index : in Natural) is
   begin
        List.Content(Index) := Element;
   end Modify;

   -- Insert an element to the list
   procedure Insert(List : in out T_List; Element : in T_Type; Index : in Natural) is
   begin
        List.Size := List.Size + 1;
        for I in reverse (Index+1)..List.Size loop
            List.Content(I) := List.Content(I-1);
        end loop;
        List.Content(Index) := Element;
   end Insert;

   -- Add list 2 to list 1
   procedure Concat(List1 : in out T_List; List2 : in T_List) is
     Size_List1 : Natural;
     Size_List2 : Natural;
   begin
        Size_List1 := GetSize(List1);
        Size_List2 := GetSize(List2);
        List1.Size := Size_List1 + Size_List2;
        for I in 1..Size_List2 loop
            List1.Content(Size_List1+I) := List2.Content(I);
        end loop;
   end Concat;

   -- Get an element from the list given its index
   function Get(List : in T_List; Index : in Natural) return T_Type is
   begin
        return List.Content(Index);
   end Get;

   -- Check if the list is full
   function IsFull(List : in T_List) return Boolean is
   begin
      return List.Size = Capacity;
   end IsFull;

   -- Check if the list is empty
   function IsEmpty(List : in T_List) return Boolean is
   begin
      return List.Size = 0;
   end IsEmpty;

   -- Determinate the size of the list
   function GetSize(List : in T_List) return Natural is
   begin
     return List.Size;
   end GetSize;

   procedure Clear(List : in out T_List) is
   begin
      List.Size := 0;
   end Clear;

end List;
