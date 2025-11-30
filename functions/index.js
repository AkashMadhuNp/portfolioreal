const functions = require('firebase-functions');
const admin = require('firebase-admin');
const sgMail = require('@sendgrid/mail');

// Initialize Firebase Admin
admin.initializeApp();

/**
 * Professional Email Notification System
 * Trigger: onCreate in contact_messages collection
 * Service: SendGrid (Industry Standard)
 * 
 * Setup:
 * 1. Get SendGrid API Key: https://app.sendgrid.com/settings/api_keys
 * 2. Set config: firebase functions:config:set sendgrid.key="YOUR_KEY"
 * 3. Deploy: firebase deploy --only functions
 */
exports.sendContactEmail = functions.firestore
  .document('contact_messages/{messageId}')
  .onCreate(async (snap, context) => {
    try {
      const data = snap.data();
      const messageId = context.params.messageId;
      
      // Extract fields
      const { name, senderEmail, messageText, timestamp } = data;
      
      // Validate required fields
      if (!name || !senderEmail || !messageText) {
        console.error('❌ Missing required fields');
        await snap.ref.update({
          emailSent: false,
          emailError: 'Missing required fields',
          attemptedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        return null;
      }

      // Get SendGrid API key from Firebase config
      const sendgridKey = functions.config().sendgrid?.key;
      
      if (!sendgridKey) {
        console.error('❌ SendGrid API key not configured');
        console.log('Run: firebase functions:config:set sendgrid.key="YOUR_SENDGRID_API_KEY"');
        await snap.ref.update({
          emailSent: false,
          emailError: 'SendGrid API key not configured',
          attemptedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        return null;
      }

      // Initialize SendGrid with API key
      sgMail.setApiKey(sendgridKey);

      // Format timestamp
      const formattedTime = timestamp 
        ? new Date(timestamp.toDate()).toLocaleString('en-US', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
          })
        : new Date().toLocaleString('en-US', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
          });

      // Professional HTML Email Template
      const htmlContent = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>New Portfolio Contact</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f5f5f5;">
  
  <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #f5f5f5; padding: 40px 20px;">
    <tr>
      <td align="center">
        
        <!-- Main Container -->
        <table width="600" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.1);">
          
          <!-- Header with Luxury Gold Gradient -->
          <tr>
            <td style="background: linear-gradient(135deg, #D4AF37 0%, #C5A028 50%, #B8941E 100%); padding: 50px 40px; text-align: center; position: relative;">
              <div style="background: rgba(0,0,0,0.1); padding: 8px 20px; border-radius: 50px; display: inline-block; margin-bottom: 20px;">
                <span style="color: #000; font-size: 12px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase;">New Message</span>
              </div>
              <h1 style="margin: 0; color: #000000; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">
                ✨ Portfolio Contact
              </h1>
              <p style="margin: 15px 0 0 0; color: rgba(0,0,0,0.7); font-size: 14px; letter-spacing: 0.5px;">
                Someone wants to connect with you!
              </p>
            </td>
          </tr>
          
          <!-- Content Body -->
          <tr>
            <td style="padding: 50px 40px;">
              
              <!-- Introduction -->
              <p style="margin: 0 0 30px 0; color: #333333; font-size: 16px; line-height: 1.7;">
                You've received a new message through your portfolio contact form. Here are the details:
              </p>
              
              <!-- Contact Details Card -->
              <div style="background: linear-gradient(135deg, #fafafa 0%, #f5f5f5 100%); border-radius: 12px; padding: 30px; margin-bottom: 30px; border-left: 5px solid #D4AF37; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                <h2 style="margin: 0 0 25px 0; color: #D4AF37; font-size: 18px; font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase;">
                  📋 Contact Information
                </h2>
                
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td style="padding: 12px 0; border-bottom: 1px solid #e5e5e5;">
                      <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td width="100" style="color: #888888; font-size: 13px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Name</td>
                          <td style="color: #222222; font-size: 16px; font-weight: 600;">${name}</td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding: 12px 0; border-bottom: 1px solid #e5e5e5;">
                      <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td width="100" style="color: #888888; font-size: 13px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Email</td>
                          <td>
                            <a href="mailto:${senderEmail}" style="color: #D4AF37; font-size: 16px; font-weight: 600; text-decoration: none; border-bottom: 2px solid #D4AF37; padding-bottom: 2px;">${senderEmail}</a>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding: 12px 0;">
                      <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td width="100" style="color: #888888; font-size: 13px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Time</td>
                          <td style="color: #555555; font-size: 14px;">${formattedTime}</td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </div>
              
              <!-- Message Content -->
              <div style="margin-bottom: 40px;">
                <h3 style="margin: 0 0 20px 0; color: #222222; font-size: 18px; font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase;">
                  💬 Their Message
                </h3>
                <div style="background-color: #ffffff; border: 2px solid #e5e5e5; border-radius: 12px; padding: 25px; box-shadow: inset 0 2px 4px rgba(0,0,0,0.03);">
                  <p style="margin: 0; color: #333333; font-size: 15px; line-height: 1.8; white-space: pre-wrap; font-family: 'Segoe UI', system-ui, sans-serif;">${messageText.replace(/</g, '&lt;').replace(/>/g, '&gt;')}</p>
                </div>
              </div>
              
              <!-- Action Button -->
              <div style="text-align: center; margin: 45px 0;">
                <table cellpadding="0" cellspacing="0" border="0" style="margin: 0 auto;">
                  <tr>
                    <td style="background: linear-gradient(135deg, #D4AF37 0%, #B8941E 100%); border-radius: 50px; box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);">
                      <a href="mailto:${senderEmail}?subject=Re:%20Your%20portfolio%20inquiry&body=Hi%20${encodeURIComponent(name)},%0D%0A%0D%0AThank you for reaching out!%0D%0A%0D%0A" 
                         style="display: inline-block; padding: 16px 45px; color: #000000; text-decoration: none; font-weight: 700; font-size: 15px; letter-spacing: 1px; text-transform: uppercase;">
                        📧 Reply Now
                      </a>
                    </td>
                  </tr>
                </table>
              </div>
              
              <!-- Pro Tip -->
              <div style="background: linear-gradient(135deg, #FFF9E6 0%, #FFF4D1 100%); border-radius: 10px; padding: 20px 25px; border-left: 5px solid #FFD700; margin-top: 35px;">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td width="40" valign="top">
                      <div style="width: 32px; height: 32px; background: #FFD700; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px;">💡</div>
                    </td>
                    <td valign="top">
                      <p style="margin: 0; color: #8B7500; font-size: 14px; line-height: 1.6; font-weight: 500;">
                        <strong style="color: #B8941E;">Pro Tip:</strong> Click the "Reply Now" button above or simply hit "Reply" in your email client to respond directly to ${name}. Your reply will automatically include their original message.
                      </p>
                    </td>
                  </tr>
                </table>
              </div>
              
            </td>
          </tr>
          
          <!-- Footer -->
          <tr>
            <td style="background: linear-gradient(to bottom, #fafafa 0%, #f5f5f5 100%); padding: 35px 40px; border-top: 1px solid #e5e5e5;">
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="text-align: center;">
                    <p style="margin: 0 0 12px 0; color: #888888; font-size: 13px; line-height: 1.6;">
                      This email was automatically sent from your <strong style="color: #666;">Portfolio Contact Form</strong>
                    </p>
                    <p style="margin: 0 0 15px 0; color: #aaaaaa; font-size: 12px;">
                      Message ID: <code style="background-color: #ffffff; padding: 4px 10px; border-radius: 4px; font-size: 11px; border: 1px solid #e0e0e0; font-family: 'Courier New', monospace;">${messageId}</code>
                    </p>
                    <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #e0e0e0;">
                      <p style="margin: 0; color: #cccccc; font-size: 11px; letter-spacing: 0.5px;">
                        Powered by <strong style="color: #B8941E;">Firebase</strong> × <strong style="color: #B8941E;">SendGrid</strong>
                      </p>
                    </div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
        </table>
        
      </td>
    </tr>
  </table>
  
</body>
</html>
      `;

      // Plain text fallback
      const textContent = `
NEW PORTFOLIO CONTACT
═══════════════════════════════════════

CONTACT INFORMATION
───────────────────
Name:  ${name}
Email: ${senderEmail}
Time:  ${formattedTime}

MESSAGE
───────────────────
${messageText}

═══════════════════════════════════════

To reply, simply respond to this email.
Your message will go directly to ${name} at ${senderEmail}.

Message ID: ${messageId}
Sent from your portfolio contact form
      `.trim();

      // SendGrid email configuration
      const msg = {
        to: '002akashakz@gmail.com',
        from: {
          email: '002akashakz@gmail.com', // Must be verified in SendGrid
          name: 'Portfolio Contact Form'
        },
        replyTo: {
          email: senderEmail,
          name: name
        },
        subject: `✨ New Portfolio Contact from ${name}`,
        text: textContent,
        html: htmlContent,
        trackingSettings: {
          clickTracking: { enable: false },
          openTracking: { enable: false }
        }
      };

      // Send email via SendGrid
      await sgMail.send(msg);
      
      console.log(`✅ Email sent successfully to 002akashakz@gmail.com`);
      console.log(`   From: ${name} (${senderEmail})`);

      // Update Firestore with success
      await snap.ref.update({
        emailSent: true,
        emailSentAt: admin.firestore.FieldValue.serverTimestamp(),
        emailService: 'SendGrid',
        emailError: null,
      });

      return { success: true };

    } catch (error) {
      console.error('❌ Error sending email:', error);
      
      // Update Firestore with error
      await snap.ref.update({
        emailSent: false,
        emailError: error.message || 'Unknown error',
        attemptedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return { success: false, error: error.message };
    }
  });

