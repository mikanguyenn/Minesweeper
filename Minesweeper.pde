import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    loop();
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
    for(int i = 0; i < 50; i++)
    setMines();
}
public void setMines(){
  
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(mines.contains(buttons[r][c]))
      setMines();
    else
      mines.add(buttons[r][c]);
}

public void draw ()
{
    background( 0 );
    if(isWon()){
        displayWinningMessage();
        noLoop();
    }
}
public boolean isWon()
{
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++)
    if(buttons[r][c].clicked == false && !mines.contains(buttons[r][c]))
    return false;
  }
  return true;
}

public void displayLosingMessage()
{
  for(int i=0;i<mines.size();i++)
        if(mines.get(i).clicked==false)
            mines.get(i).mousePressed();
     
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("L");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("S");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+3].setLabel("E");
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("W");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("I");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+3].setLabel("N");
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
          for(int i = -1; i < 2; i++){
            for(int j = -1; j < 2; j++){
              if(isValid(i + r, j + c) && buttons[i + r][j + c].clicked == false)
                buttons[i +r][j + c].mousePressed();
            }
          }
            
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
