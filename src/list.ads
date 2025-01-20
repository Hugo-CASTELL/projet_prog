generic
   type T_Type is private;
   Capacity : Natural;
package List is

   type T_List is tagged private;

   -- Initialize a list
   procedure Init(List : out T_List);

   -- Add an element at the end of the list
   procedure Add(List : in out T_List; Element : in T_Type) with
   Pre => GetSize(List) < Capacity;

   -- Modify an element at a certain index
   procedure Modify(List : in out T_List; Element : in T_Type; Index : in Natural) with
   Pre => Index <= GetSize(List);

   -- Insert an element to the desired index
   procedure Insert(List : in out T_List; Element : in T_Type; Index : in Natural) with
   Pre => Index <= GetSize(List) AND GetSize(List) < Capacity;

   -- Delete the element at a certain index
   procedure Delete(List : in out T_List; Index : in Natural) with
   Pre => GetSize(List) > 0;

   -- Add list 2 to list 1
   procedure Concat(List1 : in out T_List; List2 : in T_List) with
   Pre => (GetSize(List1) + GetSize(List2)) <= Capacity;

   -- Get an element from the list given its index
   function Get(List : in T_List; Index : in Natural) return T_Type with
   Pre => Index <= GetSize(List);

   -- Check if the list is full
   function IsFull(List : in T_List) return Boolean;

   -- Check if the list is empty
   function IsEmpty(List : in T_List) return Boolean;

   -- Determinate the size of the list
   function GetSize(List : in T_List) return Natural;


   private
    type T_Content is array (1 .. Capacity) of T_Type;

   type T_List is tagged record
      Content : T_Content;
      Size : Integer := 0;
   end record;

end List;
