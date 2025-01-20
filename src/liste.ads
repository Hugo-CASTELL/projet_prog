generic
   type T_Type is private;
   Capacity : Natural;
package List is

   type T_List is tagged private;

   -- Initialize a list
   procedure Init(List : out T_List);

   -- Ajouter un élément à la List
   procedure Add(List : in out T_List; Element : in T_Type) with
   Pre => List.Size < Capacity;

   -- Modifie un élément à la List
   procedure Modify(List : in out T_List; Element : in T_Type; Index : in Natural) with
   Pre => Index <= List.Size;

   -- Insere un élément à la List à l'index voulus (le reste est décalé a droite)
   procedure Insert(List : in out T_List; Element : in T_Type; Index : in Natural) with
   Pre => Index <= List.Size AND List.Size < Capacity;

   -- Supprimer le dernier élément de la List
   procedure Delete(List : in out T_List; Index : in Natural) with
   Pre => List.Size > 0;

   -- Add list 2 to list 1
   procedure Concat(List1 : in out T_List; List2 : in T_List) with
   Pre => (List1.Size + List2.Size) <= Capacity;

   -- Get an element from the list given its index
   function Get(List : in T_List; Index : in Natural) return T_Type with
   Pre => Index <= List.Size;

   -- Check if the list is full
   function IsFull(List : in T_List) return Boolean;

   -- Check if the list is empty
   function IsEmpty(List : in T_List) return Boolean;

   -- Determinate the size of the list
   function GetSize(List : in T_List) return Natural;


   private
    -- Définition du tableau de Content
    type T_Content is array (1 .. Capacity) of T_Type;

    -- Définition du type T_List
   type T_List is tagged record
      Content : T_Content;
      Size  : Integer := 0;
   end record;

end List;
