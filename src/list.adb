package body List is

   -- Initialize a list
   procedure Init(List : out T_List) is
   begin
      List.Taille := 0;
   end Init;

   -- Add an element to the list
   procedure Add(List : in out T_List; Element : in T_Type) is
   begin
        List.Taille := List.Taille + 1;
        List.Contenu(List.Taille) := Element;
   end Add;

   -- Delete the last element of the list
   procedure Delete(List : in out T_List; Index : in Natural) is
   begin
        for I in Index..(List.Taille-1) loop
            List.Contenu(I) := List.Contenu(I+1);
        end loop;
        List.Taille := List.Taille - 1;
   end Delete;

    -- Modify an element of the list
   procedure Modify(List : in out T_List; Element : in T_Type; Index : in Natural) is
   begin
        List.Contenu(Index) := Element;
   end Modify;

   -- Insert an element to the list
   procedure Insert(List : in out T_List; Element : in T_Type; Index : in Natural) is
   begin
        List.Taille := List.Taille + 1;
        for I in reverse (Index+1)..List.Taille loop
            List.Contenu(I) := List.Contenu(I-1);
        end loop;
        List.Contenu(Index) := Element;
   end Insert;

   -- Add list 2 to list 1
   procedure Concat(List1 : in out T_List; List2 : in T_List) is
     Taille_List1 : Natural;
     Taille_List2 : Natural;
   begin
        Taille_List1 := Taille(List1);
        Taille_List2 := Taille(List2);
        List1.Taille := Taille_List1 + Taille_List2;
        for I in 1..Taille_List2 loop
            List1.Contenu(Taille_List1+I) := List2.Contenu(I);
        end loop;
   end Concat;

   -- Get an element from the list given its index
   function Get(List : in T_List; Index : in Natural) return T_Type is
   begin
        return List.Contenu(Index);
   end Get;

   -- Check if the list is full
   function IsFull(List : in T_List) return Boolean is
   begin
      return List.Taille = Capacity;
   end IsFull;

   -- Check if the list is empty
   function IsEmpty(List : in T_List) return Boolean is
   begin
      return List.Taille = 0;
   end IsEmpty;

   -- Determinate the size of the list
   function GetSize(List : in T_List) return Natural is
   begin
          return List.Taille;
   end GetSize;

end List;
