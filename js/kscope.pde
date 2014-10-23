
class Tile {
    public int imageX;
    public int imageY;
    public int componentX;
    public int componentY;
    public int width;
    public int height;
    public int arrayX;
    public int arrayY;
}

boolean splashIsVisible = true;
PFont f;

String [] imageList = {"Tartan_Plaid_Red_Texture.jpg", "free_nature_wallpaper_fallcreek1.jpg", "Ozarks-5.jpg", "versailles2.jpg"};
int imageListIndex = -1;

PImage baseImage;

int kWidth = 1000;
int kHeight = 500;
int displaySquareSize = 100;
int transformType = 1;
int widthSquares = (kWidth / displaySquareSize)  + 1;
int heightSquares = (kHeight / displaySquareSize) + 1;

ArrayList<Tile> imageSliceData = new ArrayList<Tile>();
int numberOfGlobalMovesRemaining = 0;
String globalMoveDirection = "";
boolean getNewImage = false;

int oldMouseX = 0;
int oldMouseY = 0;

void setup() {
  
  size(1000, 500);
  
  f = createFont("Arial", 32, true);
  
  for (int x = 0; x < widthSquares; x++) {
    for (int y = 0; y < heightSquares; y++) {

        Tile tile = new Tile();
        tile.imageX = 0;
        tile.imageY = 0;
        tile.componentX = x * displaySquareSize;
        tile.componentY = y * displaySquareSize;
        tile.width = displaySquareSize;
        tile.height = displaySquareSize;
        tile.arrayX = x;
        tile.arrayY = y;

        imageSliceData.add(tile);
        
     }  
  }
}

void draw() {
  
  if (splashIsVisible == true) {
    
    background(255);
    textFont(f, 32);                 
    fill(0); 
    text("The Processing Kaleidoscope", 50, 50); 
    text("Move the mouse over the image to shift the kaleidoscope.", 50, 100); 
    text("Click the image to load another base image.", 50, 150); 
    text("Click anywhere in the white area to begin!", 50, 200); 
  }  
  else {
    
    background(0);
    
    Tile firstTile = imageSliceData.get(0);
    
    PImage subImage = baseImage.get(firstTile.imageX, firstTile.imageY, firstTile.width / 2, firstTile.height / 2);
    
    PImage upsideDownImage = turnImageUpsideDown(subImage);
    PImage sidewaysImage = turnImageSideways(subImage);
    PImage upsideDownSidewaysImage = turnImageSideways(upsideDownImage);
    PImage resultImage = assembleTransform1(subImage, sidewaysImage, upsideDownImage, upsideDownSidewaysImage);
              
    for (int a = 0; a < imageSliceData.size(); a++) {
      
      Tile tile = imageSliceData.get(a);  
      
      image(resultImage, tile.componentX, tile.componentY);
    }
  }
}

PImage turnImageUpsideDown(PImage inImage) {

  PImage resultImage = new PImage(inImage.width, inImage.height, ARGB);

  for (int x = 0; x < inImage.width; x++) {
    for (int y = 0; y < inImage.height; y++) {
       resultImage.set(x, y, inImage.get(x, inImage.height - 1 - y));
    }
  }

  return resultImage;
}

PImage turnImageSideways(PImage inImage) {

  PImage resultImage = new PImage(inImage.width, inImage.height, ARGB);

  for (int x = 0; x < inImage.width; x++) {
    for (int y = 0; y < inImage.height; y++) {
       resultImage.set(x, y, inImage.get(inImage.width - 1 - x, y));
    }
  }

  return resultImage;
}



PImage assembleTransform1(PImage subImage,
                            PImage sidewaysImage,
                            PImage upsideDownImage,
                            PImage upsideDownSidewaysImage) {

  PImage resultImage = new PImage(subImage.width * 2, subImage.height * 2, ARGB);

  for (int x = 0; x < subImage.width; x++) {
     for (int y = 0; y < subImage.height; y++) {
        resultImage.set(x, y, subImage.get(x, y));
     }
  }

  for (int x = 0; x < sidewaysImage.width; x++) {
     for (int y = 0; y < sidewaysImage.height; y++) {
        resultImage.set(x + subImage.width, y, sidewaysImage.get(x, y));
     }
  }

  for (int x = 0; x < upsideDownImage.width; x++) {
     for (int y = 0; y < upsideDownImage.height; y++) {
        resultImage.set(x, y + subImage.height, upsideDownImage.get(x, y));
     }
  }

  for (int x = 0; x < upsideDownSidewaysImage.width; x++) {
     for (int y = 0; y < upsideDownSidewaysImage.height; y++) {
        resultImage.set(x + subImage.width, y + subImage.height, upsideDownSidewaysImage.get(x, y));
      }
  }

  return resultImage;
}

void mouseMoved() {
  
  if (splashIsVisible == false) {
    
    Tile tile = imageSliceData.get(0);  
    
    if (mouseX > oldMouseX) {
      tile.imageX = tile.imageX + 1;
    }   
    if (mouseX < oldMouseX) {
      tile.imageX = tile.imageX - 1;
    }    
    
    if (tile.imageX < 0) {
      tile.imageX = 0;
    }
    if (tile.imageX > baseImage.width - tile.width - 1) {
      tile.imageX = baseImage.width - tile.width - 1;  
    }    
    
    if (mouseY > oldMouseX) {
      tile.imageY = tile.imageY + 1;
    }   
    if (mouseY < oldMouseX) {
      tile.imageY = tile.imageY + 1;
    } 
    
    if (tile.imageY < 0) {
      tile.imageY = 0;
    }
    if (tile.imageY > baseImage.height - tile.height - 1) {
      tile.imageY = baseImage.height - tile.height - 1;  
    }  
  
    oldMouseX = mouseX;
    oldMouseY = mouseY;
  }
  
}

void mouseClicked() {
            
  splashIsVisible = false;
  
  imageListIndex = imageListIndex + 1;
  if (imageListIndex > imageList.length - 1) {
    imageListIndex = 0;
  }
  
  baseImage = loadImage(imageList[imageListIndex]);
  
  for (int a = 0; a < imageSliceData.size(); a++) {
    
     Tile tile = imageSliceData.get(a);  
     tile.imageX = 0;
     tile.imageY = 0;
  }
}
