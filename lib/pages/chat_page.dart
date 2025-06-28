import 'package:flutter/material.dart';

// --- MODEL DATA BARU UNTUK DAFTAR PERCAKAPAN ---
class ChatConversation {
  final String userName;
  final String userAvatarUrl;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isPinned;

  ChatConversation({
    required this.userName,
    required this.userAvatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isPinned = false,
  });
}

// --- NAMA HALAMAN DIUBAH AGAR LEBIH SESUAI ---
class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  // --- DATA TIRUAN UNTUK DAFTAR CHAT ---
  final List<ChatConversation> chatConversations = [
    ChatConversation(
      userName: 'Admin Kampus',
      userAvatarUrl: 'https://www.astbyte.com/icon.png',
      lastMessage: 'Baik, jadwal ujian akan diumumkan...',
      lastMessageTime: '10:33',
      unreadCount: 2,
      isPinned: true,
    ),
    ChatConversation(
      userName: 'Dr. Anisa, S.Kom., M.Kom.',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=5',
      lastMessage: 'Tolong kirimkan revisi bab 3 Anda.',
      lastMessageTime: '09:45',
      unreadCount: 1,
      isPinned: true,
    ),
    ChatConversation(
      userName: 'Grup Proyek Aplikasi Mobile',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=10',
      lastMessage: 'Sarah: Jangan lupa deadline besok ya!',
      lastMessageTime: 'Kemarin',
    ),
    ChatConversation(
      userName: 'John Doe',
      userAvatarUrl:
          'https://digiroister.com/wp-content/uploads/2021/02/team-1.jpg',
      lastMessage: 'Oke, siap. Terima kasih infonya!',
      lastMessageTime: 'Kemarin',
    ),
    ChatConversation(
      userName: 'Perpustakaan Pusat',
      userAvatarUrl:
          'https://unair.ac.id/wp-content/uploads/2022/07/perpustakaan.jpg',
      lastMessage: 'Pengembalian buku Anda jatuh tempo lusa.',
      lastMessageTime: '26/06/25',
    ),
    ChatConversation(
      userName: 'BEM Fakultas Teknik',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=20',
      lastMessage: 'Info terbaru seputar Masta 2025.',
      lastMessageTime: '25/06/25',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- APPBAR MODERN ---
      appBar: AppBar(
        title: Text(
          'Pesan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey.shade700),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey.shade700),
            onPressed: () {},
          ),
          SizedBox(width: 8),
        ],
      ),
      // --- BODY UTAMA DENGAN DAFTAR CHAT ---
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: chatConversations.length,
        itemBuilder: (context, index) {
          final chat = chatConversations[index];
          return ChatListItem(conversation: chat);
        },
        separatorBuilder:
            (context, index) => Divider(
              height: 1,
              thickness: 1,
              indent: 80, // Memberi jarak agar garis tidak menyentuh avatar
              endIndent: 16,
              color: Colors.grey.shade200,
            ),
      ),
      // --- FLOATING ACTION BUTTON UNTUK CHAT BARU ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.edit_square, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

// --- WIDGET BARU UNTUK SETIAP BARIS CHAT ---
class ChatListItem extends StatelessWidget {
  final ChatConversation conversation;

  const ChatListItem({Key? key, required this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Aksi saat item chat diklik, misalnya navigasi ke ruang obrolan.
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomPage(conversation: conversation)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Foto Profil
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(conversation.userAvatarUrl),
            ),
            SizedBox(width: 16),
            // Nama, Pesan Terakhir, dan Ikon
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.userName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    conversation.lastMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          conversation.unreadCount > 0
                              ? Colors.black87
                              : Colors.grey.shade600,
                      fontWeight:
                          conversation.unreadCount > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            // Waktu dan Jumlah Pesan Belum Dibaca
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  conversation.lastMessageTime,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        conversation.unreadCount > 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade500,
                    fontWeight:
                        conversation.unreadCount > 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
                SizedBox(height: 6),
                if (conversation.unreadCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      conversation.unreadCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else if (conversation.isPinned)
                  Icon(Icons.push_pin, size: 18, color: Colors.grey.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
