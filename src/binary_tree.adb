with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body Binary_Tree is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Node, Name => T_Tree);

  -- ### Constructor ###

  procedure Init(Tree: out T_Tree; Data: in T_Data) is
   begin
      Tree := new T_Node'(Data => Data, Left => null, Right => null);
   end Init;

  -- ### Getters / Setters ###

	-- Returns the value of the binary tree's branch
	function GetLeft (Tree: in T_Tree) return T_Tree is 
  begin
    return Tree.Left; 
  end GetLeft;

	-- Change the value of the binary tree's left branch
	procedure SetLeft (Tree: in out T_Tree; Data: in T_Data) is
  begin
    Init(Tree.Left, Data);
  end SetLeft;

	-- Clears the value of the binary tree's left branch
	procedure ClearLeft (Tree: in out T_Tree) is
  begin
    Tree.Left := null;
  end ClearLeft;

	-- Returns the value of the binary tree's right branch
	function GetRight (Tree: in T_Tree) return T_Tree is
  begin
    return Tree.Right; 
  end GetRight;

	-- Change the value of the binary tree's right branch
	procedure SetRight (Tree: in out T_Tree; Data: in T_Data) is
  begin
    Init(Tree.Right, Data);
  end SetRight;

	-- Clears the value of the binary tree's right branch
	procedure ClearRight (Tree: in out T_Tree) is
  begin
    Tree.Right := null;
  end ClearRight;

	-- Returns the data of the binary tree
	function GetData (Tree: in T_Tree) return T_Data is 
  begin
    return Tree.Data; 
  end GetData;

  -- ### Functions ###

	-- Determine if the tree's branch is empty
	function IsBranchEmpty (Tree: in T_Tree; left: in Boolean) return Boolean is
  begin
    if (left = True) then
      return Tree.Left = null;
    else
      return Tree.Right = null;
    end if;
  end IsBranchEmpty;

	-- Determine if the tree is a leaf
	function IsLeaf (Tree: in T_Tree) return Boolean is
  begin
    return IsBranchEmpty(Tree, True) and IsBranchEmpty(Tree, False); 
  end IsLeaf;

	-- Determine if the tree has a data
	function IsEmpty (Tree: in T_Tree) return Boolean is
  begin
    return Tree = null; 
  end IsEmpty;

	-- Returns the size of the tree
	function GetSize (Tree: in T_Tree) return Integer is
    Left_Size : Integer := 0;
    Right_Size : Integer := 0;
  begin

    -- Get the size of the left branch if exists
    if (IsBranchEmpty(Tree, True) = False) then
      Left_Size := 1 + GetSize(Tree.Left);
    end if;

    -- Get the size of the right branch if exists
    if (IsBranchEmpty(Tree, True) = False) then
      Right_Size := 1 + GetSize(Tree.Right);
    end if;

    -- Addition both and return
    return Left_Size + Right_Size;

  end GetSize;

	-- Print the binary tree in the console
	procedure Print (Tree: in T_Tree) is
  begin
    Put("TODO");
  end Print;

end Binary_Tree;
