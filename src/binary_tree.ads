generic
	type T_Data is private;
  with function Is_Null(Data : T_Data) return Boolean is <>;

package Binary_Tree is

  -- #--------#
  -- # T_Tree #
  -- #--------#

  -- ### Type and Exceptions ###

	type T_Tree is private;

	Null_Tree_Exception: Exception;	

  -- ### Constructor ###

	-- Initialize a Tree with a data
	procedure Init(Tree: in out T_Tree; Data: in T_Data) with
		Post => (IsBranchEmpty(Tree, True) and IsBranchEmpty(Tree, False)) and (IsEmpty(Tree) = False);

  -- ### Getters / Setters ###

	-- Returns the value of the binary tree's branch
	function GetLeft (Tree: in T_Tree) return T_Tree; 

	-- Change the value of the binary tree's left branch
	procedure SetLeft (Tree: in out T_Tree; Data: in T_Data) with
		Post => IsBranchEmpty(Tree, True) = False;

	-- Clears the value of the binary tree's left branch
	procedure ClearLeft (Tree: in out T_Tree) with
		Post => IsBranchEmpty(Tree, True) and GetSize(Tree) < GetSize(Tree)'Old ;

	-- Returns the value of the binary tree's right branch
	function GetRight (Tree: in T_Tree) return T_Tree; 

	-- Change the value of the binary tree's right branch
	procedure SetRight (Tree: in out T_Tree; Data: in T_Data) with
		Post => IsBranchEmpty(Tree, False) = False;

	-- Clears the value of the binary tree's right branch
	procedure ClearRight (Tree: in out T_Tree) with
		Post => IsBranchEmpty(Tree, False) and GetSize(Tree) < GetSize(Tree)'Old;

	-- Returns the data of the binary tree
	function GetData (Tree: in T_Tree) return T_Data; 

  -- ### Functions ###

	-- Determine if the tree's branch is empty
	function IsBranchEmpty (Tree: in T_Tree; left: in Boolean) return Boolean;

	-- Determine if the tree is a leaf
	function IsLeaf (Tree: in T_Tree) return Boolean;

	-- Determine if the tree has a data
	function IsEmpty (Tree: T_Tree) return Boolean;

	-- Returns the size of the tree
	function GetSize (Tree: in T_Tree) return Natural with
		Post => (GetSize'Result = 1) = ((IsBranchEmpty(Tree, True) and IsBranchEmpty(Tree, False)));

  procedure Delete(Tree: in out T_Tree) with
		Post => IsEmpty(Tree);

private

  -- #--------#
  -- # T_Node #
  -- #--------#

	type T_Node;
	type T_Tree is access T_Node;
	type T_Node is
		record
			Data: T_Data;
			Left: T_Tree;
			Right: T_Tree;
		end record;

end Binary_Tree;
