import de.bezier.guido.*;
private final static int NUM_ROWS = 5;
private final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    
    setMines();
}
public void setMines(){
  for(int i = 0; i < 20; i++){
    final int r = (int)(Math.random()*NUM_ROWS);
    final int c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
    }
      i++;
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS||r >= NUM_ROWS|| c < NUM_COLS||c >= NUM_COLS)  
    return true;
    return false;
}
public int countMines(int row, int col)
{
  int count = 0;
  if(isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
  count++;
   if(isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
  count++;
  if(isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
  count++;
  if(isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
  count++;
  if(isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
  count++;
  if(isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
  count++;
  if(isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
  count++;
  if(isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
  count++;    
  return count;
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = row;
        c = col; 
        x = c*width;
        y = r*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
            clicked = false;
          }
          else if(flagged == false)
            flagged = true;
        }
        else if(mines.contains(this))
          displayLosingMessage();
        else if(countMines(r,c) > 0)
          setLabel("" + countMines(r,c));
        else{
          if(isValid(r,c-1) && buttons[r][c-1].clicked == false)
             buttons[r][c-1].mousePressed();
          if(isValid(r,c+1) && buttons[r][c-1].clicked == false)
             buttons[r][c+1].mousePressed();
          if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked == false)
            buttons[r-1][c-1].mousePressed();
          if(isValid(r-1,c) && buttons[r-1][c].clicked == false)
            buttons[r-1][c].mousePressed();
          if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked == false)
            buttons[r-1][c+1].mousePressed();
          if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked == false)
            buttons[r+1][c-1].mousePressed();
          if(isValid(r+1,c) && buttons[r+1][c].clicked == false)
            buttons[r+1][c].mousePressed();
          if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked == false)
            buttons[r+1][c+1].mousePressed();
            
        }
    }        
          

    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
