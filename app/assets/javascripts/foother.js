/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function getClientHeight() {
 if (window.opera) {
  return (self.innerHeight || ( de && de.clientHeight ) || document.body.clientHeight);
 } else {
  return document.compatMode=='CSS1Compat'?document.documentElement.clientHeight:document.body.clientHeight;
 }
}