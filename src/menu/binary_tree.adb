with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body Binary_Tree is

  -- ### Constructor ###

	-- Initialize a Tree with a data
  procedure Init(Tree: in out T_Tree; Data: in T_Data) is
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
    Delete(Tree.Left);
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
    Delete(Tree.Right);
  end ClearRight;

	-- Returns the data of the binary tree
	function GetData (Tree: in T_Tree) return T_Data is 
  begin
    return Tree.Data; 
  end GetData;

  -- ### Functions ###

	-- Determine if the tree's branch is empty
	function IsBranchEmpty (Tree: in T_Tree; left: in Boolean) return Boolean is
    branch : T_Tree;
  begin
    Put("IsBranchEmpty");
    if left then
      return IsEmpty(Tree.Left);
    else
      return IsEmpty(Tree.Right);
    end if;
  end IsBranchEmpty;

	-- Determine if the tree is a leaf
	function IsLeaf (Tree: in T_Tree) return Boolean is
  begin
    return IsBranchEmpty(Tree, True) and IsBranchEmpty(Tree, False); 
  end IsLeaf;

	-- Determine if the tree has a data
	function IsEmpty (Tree: T_Tree) return Boolean is
    data : T_Data;
  begin
    Put_Line("IsEmpty");
    Put_Line(Tree'Image);
    return Tree = null or else Is_Null(Tree.Data);
  end IsEmpty;

	-- Returns the size of the tree
	function GetSize (Tree: in T_Tree) return Natural is
    Left_Size : Natural := 0;
    Right_Size : Natural := 0;
  begin
    if IsEmpty(Tree) then
      return 0;
    end if;
    Put("IsEmptyTree");

    -- Get the size of the left branch if exists
    if (IsBranchEmpty(Tree, True) = False) then
    Put("LEFT");
      Left_Size := GetSize(GetLeft(Tree));
    Put("LEFT");
    end if;

    -- Get the size of the right branch if exists
    if (IsBranchEmpty(Tree, False) = False) then
    Put("Right");
      Right_Size := GetSize(GetRight(Tree));
    end if;

    -- Addition both and 1
    return 1 + Left_Size + Right_Size;

  end GetSize;

	-- Print the binary tree in the console
	procedure Print (Tree: in T_Tree) is
  begin
    Put("TODO");
  end Print;

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Node, Name => T_Tree);

  -- Deletes the binary tree and each of its ancestors 
	procedure Delete(Tree: in out T_Tree) is
  begin
    if IsEmpty(Tree) then
      return;
    end if;

    -- Recursive deleting
    if IsBranchEmpty (Tree, False) = False then
      Delete(Tree.Right);
      Tree.Right := null;
    end if;
    if IsBranchEmpty (Tree, True) = False then
      Delete(Tree.Left);
      Tree.Left := null;
    end if;

    -- Delete if leaf confirmed
    if IsLeaf(Tree) then
      Free(Tree);
      Tree := null;
      Put_Line("Deleting node with data: " & Tree'Image);
    end if;
  end Delete;

end Binary_Tree;
